require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe ActionGenerator do

    before(:each) do
      @person = Person.new(:first_name => "Mr",
                           :family_name => "Test")
      @action_generator = ActionGenerator.new

      @midday = Time.new(:hour => 12)
      @action_generator.time = @midday
    end
 
    it "should hold a copy of the time" do
      @action_generator.time.should_not be_nil
    end

    it "should hold a copy of the time of type Town::Time" do
      @action_generator.time.should be_is_a Time
    end

    it "should let time be updated" do
      lambda{@action_generator.time = Town::Time.new}.should_not raise_error 
    end
   
    it "should have a next_action method which takes a thing" do
      lambda{@action_generator.next_action(@person)}.should_not raise_error 
    end 

    it "should have a next_action method which only takes a thing" do
      lambda{@action_generator.next_action(Action.new)}.should raise_error ArgumentError
    end 

    it "should have next_action return IdleAction by default" do
      @action_generator.next_action(@person).should be_is_a IdleAction
    end
  
    context "bed time" do
      before(:each) do
        @person.bedtime_hour = 23
        @twentytwo = Time.new(:hour => 22)
        @twentythree = Time.new(:hour => 23)
        @midnight = Time.new(:hour => 0)
        @action_generator.time = @twentytwo
      end

      it "should have next_action return IdleAction if it is before" do
        @action_generator.next_action(@person).should be_is_a IdleAction
      end

      it "should have next_action return SleepAction if it is after" do
        @action_generator.time = @twentythree
        @action_generator.next_action(@person).should be_is_a SleepAction
      end

      it "should have next_action return SleepAction if it is after and the next day" do
        @action_generator.time = @midnight
        @action_generator.next_action(@person).should be_is_a SleepAction
      end

    end
   
    context "wake time" do
      before(:each) do
        @person.wake_up_hour = 7
        @person.current_action = SleepAction.new
        @six = Time.new(:hour => 6)
        @seven = Time.new(:hour => 7)
        @action_generator.time = @six
      end

      it "should have next_action return SleepAction if it is already Sleeping and is before" do
        @action_generator.next_action(@person).should be_is_a SleepAction
      end

      it "should have next_action return WakeAction if it is already Sleeping and is after" do
        @action_generator.time = @seven
        @action_generator.next_action(@person).should be_is_a WakeAction
      end
    end

    context "night sleeper" do

      before(:each) do
        @person.bedtime_hour = 1
        @person.wake_up_hour = 10
      end 

      context "bed time" do
        before(:each) do
          @twentythree = Time.new(:hour => 0)
          @midnight = Time.new(:hour => 0)
          @one = Time.new(:hour => 1)
        end

        it "should have next_action return IdleAction if it is the day before" do
          @action_generator.time = @twentythree
          @action_generator.next_action(@person).should be_is_a IdleAction
        end

        it "should have next_action return IdleAction if it is before" do
          @action_generator.time = @midnight
          @action_generator.next_action(@person).should be_is_a IdleAction
        end

        it "should have next_action return SleepAction if it is after" do
          @action_generator.time = @one
          @action_generator.next_action(@person).should be_is_a SleepAction
        end
      end
     
      context "wake time" do
        before(:each) do
          @person.current_action = SleepAction.new
          @nine = Time.new(:hour => 9)
          @ten = Time.new(:hour => 10)
        end

        it "should have next_action return SleepAction if it is already Sleeping and is before" do
          @action_generator.time = @nine
          @action_generator.next_action(@person).should be_is_a SleepAction
        end
  
        it "should have next_action return WakeAction if it is already Sleeping and is after" do
          @action_generator.time = @ten
          @action_generator.next_action(@person).should be_is_a WakeAction
        end

        it "should be waking up for 5 minutes" do 
          @action_generator.time = @ten
          5.times do
            @action_generator.time.minute += 1
            action =  @action_generator.next_action(@person)
            action.should be_is_a WakeAction
            @person.current_action = action
          end
          @action_generator.time.minute += 1
          action =  @action_generator.next_action(@person)
          action.should_not be_is_a WakeAction
          @person.current_action = action
        end
   
        context "and eating breakfast" do

          before(:each) do
            @action_generator.time = @ten
            5.times do
              @action_generator.time.minute += 1
              @person.current_action =  @action_generator.next_action(@person)
            end
            @action_generator.time.minute += 1
            @action =  @action_generator.next_action(@person)
          end

          it "should go to EatAction after waking up" do
            @action.should be_is_a EatAction
          end
 
          it "should have the meal name be Breakfast" do
            @action.meal_name.should eql "Breakfast"
          end
        end
      end
    end

    context "person with a job" do
  
      before(:each) do
        @seven = Time.new(:hour => 7)
        @eight = Time.new(:hour => 8)
        @nine = Time.new(:hour => 9)
        @ten = Time.new(:hour => 10)
        @seventeen = Time.new(:hour => 17)
        @eightteen = Time.new(:hour => 18)
        @person.job = JobRole.new(:name => "Forester")
      end

      it "should not walk to work before an hour before start time" do
        @action_generator.time = @seven
        @person.current_action =  @action_generator.next_action(@person)
        @person.current_action.should_not be_is_a WalkAction
      end

      it "should walk to work an hour before start time" do
        @action_generator.time = @eight
        @person.current_action =  @action_generator.next_action(@person)
        @person.current_action.should be_is_a WalkAction
      end

      it "should not be walking to work after work start time" do
        @action_generator.time = @nine
        @person.current_action =  @action_generator.next_action(@person)
        @person.current_action.should_not be_is_a WalkAction
      end

      it "should be working after work start time" do
        @action_generator.time = @nine
        @person.current_action =  @action_generator.next_action(@person)
        @person.current_action.should be_is_a WorkAction
      end

      it "should not working after work end time" do
        @action_generator.time = @eightteen
        @person.current_action =  @action_generator.next_action(@person)
        @person.current_action.should_not be_is_a WorkAction
      end


    end
  end
end

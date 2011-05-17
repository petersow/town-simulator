require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe ActionGenerator do

    before(:each) do
      @person = Person.new(:first_name => "Mr",
                           :family_name => "Test")
      @action_generator = ActionGenerator.new
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

  end
end

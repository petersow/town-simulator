require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe Engine do

    context "people config for 1 person" do

      before(:each) do
        @people_config = YAML::load(File.open('spec/fixtures/one_person.yaml'))
        @engine = Engine.new(:people_config => @people_config)
        @person = @engine.people.first
      end

      it "should let me pass in a person config array" do
        lambda{Engine.new(:people_config => @people_config)}.should_not raise_error
      end
    
      it "should have 1 person" do
        @engine.people.size.should eql 1
      end

      it "should have a person with the name Stick" do
        @person.first_name.should eql "Stick"
      end

      it "should have a person with the family name Boy" do
        @person.family_name.should eql "Boy"
      end

      it "should have a person with the bedtime hour of 22" do
        @person.bedtime_hour.should eql 22
      end

      it "should have a person with the wake up hour of 8" do
        @person.wake_up_hour.should eql 8
      end
    end

    context "people config for 2 people" do
      before(:each) do
        @people_config = YAML::load(File.open('spec/fixtures/two_people.yaml'))
        @engine = Engine.new(:people_config => @people_config)
      end
    
      it "should have 2 people" do
        @engine.people.size.should eql 2
      end

      it "should have different family names" do
        @engine.people.first.family_name.should_not eql @engine.people.last.family_name
      end
    end

    context "Starting up" do

      before(:each) do
        @messenger = mock(:messenger).as_null_object
        @clock = mock(:clock).as_null_object
        @clock.stub!(:to_s).and_return("00:01 01/01/1")
        @engine = Engine.new(:messenger => @messenger, :clock => @clock, 
                             :seconds_to_run => 1, :sleep_time => 0)
      end

      it "should send a welcome message" do
        @messenger.should_receive(:puts).with("Welcome to the Town!")
        @engine.start
      end

      it "should tick the clock" do
        @clock.should_receive(:tick)
        @engine.start
      end

      it "should tick the clock 5 times for 5 seconds" do
        @engine.seconds_to_run = 5
        @clock.should_receive(:tick).at_least(5).times
        @engine.start
      end

      it "should print the time onto the messenger" do
        @messenger.should_receive(:puts).with("Welcome to the Town!")
        @messenger.should_receive(:puts).with(/00:01 01\/01\/1/)
        @engine.start
      end

      it "should have an array of people" do
        @engine.people.should_not be_nil
      end

    end

  end
end

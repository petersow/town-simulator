require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe WalkAction do

    before(:each) do
      @walk_action = WalkAction.new
    end

    it "should be a subclass of Action" do
      @walk_action.should be_is_a Action
    end

    it "should have a name of Walk" do
      @walk_action.name.should eql "Walk"
    end

    it "should have a to_s of Walking to {end_location}" do
      @walk_action.end_location = "School"
      @walk_action.to_s.should eql "Walking to School"
    end

    it "should have a type of active" do
      @walk_action.type.should eql "active"
    end

    it "should have an end location" do
      @walk_action.end_location.should_not be_nil
    end

    it "should default end location to Nowhere" do
      @walk_action.end_location.should eql "Nowhere"
    end

    it "should let end location be changed" do
      @walk_action.end_location = "Work"
      @walk_action.end_location.should eql "Work"
    end

    it "should let end location be changed at creation" do
      church = WalkAction.new(:end_location => "Church")
      church.end_location.should eql "Church"
    end

    it "should have an start location" do
      @walk_action.start_location.should_not be_nil
    end

    it "should default start location to Nowhere" do
      @walk_action.start_location.should eql "Nowhere"
    end

    it "should let start location be changed" do
      @walk_action.start_location = "Work"
      @walk_action.start_location.should eql "Work"
    end

    it "should let start location be changed at creation" do
      church = WalkAction.new(:start_location => "Church")
      church.start_location.should eql "Church"
    end
   
    it "should have a time_remaining" do
      @walk_action.time_remaining.should_not be_nil
    end

    it "should default time_remaining to 59" do
      @walk_action.time_remaining.should eql 59
    end

    it "should return true for is_finished? if time_remaining is 0 or below" do
      @walk_action.time_remaining = 0
      @walk_action.should be_is_finished
      @walk_action.time_remaining = -1
      @walk_action.should be_is_finished
    end

    it "should return false for is_finished? if time_remaining is above 0" do
      @walk_action.time_remaining = 1
      @walk_action.should_not be_is_finished
    end

    it "should decrement time_remaining by 1 for step" do
      @walk_action.time_remaining = 4
      @walk_action.step
      @walk_action.time_remaining.should eql 3
    end
  end
end

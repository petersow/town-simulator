require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module Town
  describe WakeAction do

    before(:each) do
      @wake_action = WakeAction.new
    end

    it "should be a subclass of Action" do
      @wake_action.should be_is_a Action
    end

    it "should have a name of Wake" do
      @wake_action.name.should eql "Wake"
    end

    it "should have a to_s of Waking up" do
      @wake_action.to_s.should eql "Waking up"
    end

    it "should have a type of active" do
      @wake_action.type.should eql "active"
    end
   
    it "should have a time_remaining" do
      @wake_action.time_remaining.should_not be_nil
    end

    it "should default time_remaining to 5" do
      @wake_action.time_remaining.should eql 5
    end

    it "should return true for is_finished? if time_remaining is 0 or below" do
      @wake_action.time_remaining = 0
      @wake_action.should be_is_finished
      @wake_action.time_remaining = -1
      @wake_action.should be_is_finished
    end

    it "should return false for is_finished? if time_remaining is above 0" do
      @wake_action.time_remaining = 1
      @wake_action.should_not be_is_finished
    end

    it "should decrement time_remaining by 1 for step" do
      @wake_action.time_remaining = 4
      @wake_action.step
      @wake_action.time_remaining.should eql 3
    end
  end
end

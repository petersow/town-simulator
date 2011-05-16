require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe SleepAction do

    before(:each) do
      @sleep_action = SleepAction.new
    end

    it "should be a subclass of Action" do
      @sleep_action.should be_is_a Action
    end

    it "should have a name of Sleep" do
      @sleep_action.name.should eql "Sleep"
    end

    it "should have a to_s of Sleeping" do
      @sleep_action.to_s.should eql "Sleeping"
    end

    it "should have a type of passive" do
      @sleep_action.type.should eql "passive"
    end

  end
end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

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

    it "should have a type of passive" do
      @wake_action.type.should eql "passive"
    end

    it "should return true for is_finished?" do
      @wake_action.should be_is_finished
    end
  end
end

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

    it "should have a to_s of Walking" do
      @walk_action.to_s.should eql "Walking"
    end

    it "should have a type of passive" do
      @walk_action.type.should eql "passive"
    end

    it "should return true for is_finished?" do
      @walk_action.should be_is_finished
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe IdleAction do

    before(:each) do
      @idle_action = IdleAction.new
    end

    it "should be a subclass of Action" do
      @idle_action.should be_is_a Action
    end

    it "should have a name of Idle" do
      @idle_action.name.should eql "Idle"
    end

    it "should have a to_s of Idle" do
      @idle_action.to_s.should eql "Idle"
    end

    it "should have a type of passive" do
      @idle_action.type.should eql "passive"
    end

  end
end

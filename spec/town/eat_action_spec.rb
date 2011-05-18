require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe EatAction do

    before(:each) do
      @eat_action = EatAction.new
    end

    it "should be a subclass of Action" do
      @eat_action.should be_is_a Action
    end

    it "should have a name of Eat" do
      @eat_action.name.should eql "Eat"
    end

    it "should have a to_s of Eating" do
      @eat_action.to_s.should eql "Eating"
    end

    it "should have a type of passive" do
      @eat_action.type.should eql "passive"
    end

    it "should return true for is_finished?" do
      @eat_action.should be_is_finished
    end
  end
end

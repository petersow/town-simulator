require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

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

    it "should have a to_s of Eating {meal_name}" do
      @eat_action.meal_name = "Brunch"
      @eat_action.to_s.should eql "Eating Brunch"
    end

    it "should have a type of active" do
      @eat_action.type.should eql "active"
    end

    it "should have a meal name" do
      @eat_action.meal_name.should_not be_nil
    end

    it "should default meal name to Snack" do
      @eat_action.meal_name.should eql "Snack"
    end

    it "should let meal name be changed" do
      @eat_action.meal_name = "Lunch"
      @eat_action.meal_name.should eql "Lunch"
    end

    it "should let meal name be changed at creation" do
      dinner = EatAction.new(:meal_name => "Dinner")
      dinner.meal_name.should eql "Dinner"
    end
   
    it "should have a time_remaining" do
      @eat_action.time_remaining.should_not be_nil
    end

    it "should default time_remaining to 20" do
      @eat_action.time_remaining.should eql 20
    end

    it "should return true for is_finished? if time_remaining is 0 or below" do
      @eat_action.time_remaining = 0
      @eat_action.should be_is_finished
      @eat_action.time_remaining = -1
      @eat_action.should be_is_finished
    end

    it "should return false for is_finished? if time_remaining is above 0" do
      @eat_action.time_remaining = 1
      @eat_action.should_not be_is_finished
    end

    it "should decrement time_remaining by 1 for step" do
      @eat_action.time_remaining = 4
      @eat_action.step
      @eat_action.time_remaining.should eql 3
    end
  end
end

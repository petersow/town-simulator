require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module Town
  describe ActiveWalkAction do

    before(:each) do
      person_start = Location.new(:x => 0, :z => 10)
      @person = Person.new(:first_name => "Pete", :last_name => "Walkalot",
                           :location => person_start)

      place_location = Location.new(:x => 100, :z => 50)
      @place = Place.new(:name => "Butchers", :location => place_location)
      @walk_action = ActiveWalkAction.new(:thing => @person,
                                          :end_location => @place)
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

    it "should move the players towards the location each step" do
      old_location = @person.location.clone
      @walk_action.step
      puts @person.location.inspect
      @person.location.should_not eql old_location
    end

    it "should get to the end_location" do
      x = 0
      while @walk_action.is_finished? == false
        @walk_action.step
        x += 1
      end
      puts x
    end
   
  end
end

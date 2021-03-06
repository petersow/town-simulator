require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe Thing do

    before(:each) do
      @thing = Thing.new
    end

    it "has a t_id" do
      @thing.t_id.should_not be_nil
    end

    it "has a unique t_id" do
      things = []
      1000.times do
        things << Thing.new
      end

      things.each do |thing|
        thing.t_id.should_not eql @thing.t_id
      end
    end

    it "should not let t_id be set" do
      lambda{@thing.t_id = 1}.should raise_error 
    end

    it "has a location" do
      @thing.location.should_not be_nil
    end

    it "has a location which is of type Town::Location" do
      @thing.location.should be_is_a Location
    end 

    it "should let location be set" do
      lambda{@thing.location = Location.new}.should_not raise_error 
    end

    it "should let location be set at creation" do
      location = Location.new(:x => 100)
      thing = Thing.new(:location => location)
      thing.location.x.should eql 100
    end

    it "has a current action" do
      @thing.current_action.should_not be_nil
    end

    it "has an current action of type Town::Action" do
      @thing.current_action.should be_is_a Action
    end

    it "should default current action to Idle" do
      @thing.current_action.should be_is_a IdleAction
    end

    it "should let the current action be changed" do
      old_id = @thing.current_action.a_id
      @thing.current_action = Action.new(:name => "Walking")
      @thing.current_action.a_id.should_not eql old_id
    end

  end
end

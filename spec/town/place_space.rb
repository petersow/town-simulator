require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe Place do
    before(:each) do
      @place = Town::Place.new
    end

    it "has a p_id" do
      @place.p_id.should_not be_nil
    end

    it "has a unique p_id" do
      places = []
      1000.times do
        places << Place.new
      end

      places.each do |place|
        place.p_id.should_not eql @place.p_id
      end
    end

    it "should not let p_id be set" do
      lambda{@place.p_id = 1}.should raise_error 
    end

    it "should have a name" do
      @place.name.should_not be_nil
    end

    it "should let name be changed" do
      @place.name = "Forester"
      @place.name.should eql "Forester"
    end

    it "should let name be set at creation" do
      place = Place.new(:name => "Fisher") 
      place.name.should eql "Fisher"
    end

    it "has a location" do
      @place.location.should_not be_nil
    end

    it "has a location which is of type Town::Location" do
      @place.location.should be_is_a Location
    end 

    it "should let location be set" do
      lambda{@place.location = Location.new}.should_not raise_error 
    end

    it "should let location be set at creation" do
      location = Location.new(:x => 100)
      place = Thing.new(:location => location)
      place.location.x.should eql 100
    end

  end
end

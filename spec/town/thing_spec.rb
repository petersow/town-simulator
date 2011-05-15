require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'securerandom'

module Town

  describe Thing do

    before(:each) do
      @thing = Thing.new
    end

    it "has a t_id" do
      @thing.t_id.should_not be_nil
    end

    it "has a uniqute t_id" do
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


  end

  

end

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

    it "has a location" do
      @thing.location.should_not be_nil
    end

  end

  

end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe Location do
  
    before(:each) do
      @location = Location.new
    end    

    it "has an x variable" do
      @location.x.should_not be_nil
    end

    it "the variable x defaults to 0" do
      @location.x.should eql 0
    end

    it "variable x should be read and writeable" do
      @location.x = 1000
      @location.x.should eql 1000
    end

    it "has an y variable" do
      @location.y.should_not be_nil
    end

    it "the variable y defaults to 0" do
      @location.y.should eql 0
    end

    it "variable y should be read and writeable" do
      @location.y = 1000
      @location.y.should eql 1000
    end

    it "has an z variable" do
      @location.z.should_not be_nil
    end

    it "the variable z defaults to 0" do
      @location.z.should eql 0
    end

    it "variable z should be read and writeable" do
      @location.z = 1000
      @location.z.should eql 1000
    end
  end
end

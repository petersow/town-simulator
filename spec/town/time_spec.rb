require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe Time do

    before(:each) do
      @time = Town::Time.new
    end 

    it "has a year variable" do
      @time.year.should_not be_nil
    end

    it "should let year be set" do
      @time.year = 100
      @time.year.should eql 100
    end

    it "should let year be set at creation time" do
      time = Time.new(:year => 999)
      time.year.should eql 999 
    end

    it "has a month variable" do
      @time.month.should_not be_nil
    end

    it "should let month be set" do
      @time.month = 777
      @time.month.should eql 777
    end

    it "should let month be set at creation time" do
      time = Time.new(:month => 800)
      time.month.should eql 800
    end

    it "has a day variable" do
      @time.day.should_not be_nil
    end

    it "should let day be set" do
      @time.day = 10
      @time.day.should eql 10
    end

    it "should let day be set at creation time" do
      time = Time.new(:day => 80)
      time.day.should eql 80
    end

    it "has an hour variable" do
      @time.hour.should_not be_nil
    end

    it "should let hour be set" do
      @time.hour = 15
      @time.hour.should eql 15
    end

    it "should let hour be set at creation time" do
      time = Time.new(:hour => 75)
      time.hour.should eql 75
    end

    it "has a minute variable" do
      @time.minute.should_not be_nil
    end

    it "should let minute be set" do
      @time.minute = 15
      @time.minute.should eql 15
    end

    it "should let minute be set at creation time" do
      time = Time.new(:minute => 75)
      time.minute.should eql 75
    end


  end
end


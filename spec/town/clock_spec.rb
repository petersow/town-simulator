require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'town/clock'

describe Town::Clock do

  before(:each) do
    @clock = Town::Clock.new
  end

  it "has a year variable" do
    @clock.year.should_not be_nil
  end

  it "starts the year at 1" do
    @clock.year.should eql 1
  end

  it "doesn't let you set the year variable" do
    lambda{@clock.year = 1}.should raise_error 
  end

  it "has a month variable" do
    @clock.month.should_not be_nil
  end

  it "starts the month at 1" do
    @clock.month.should eql 1
  end

  it "doesn't let you set the month variable" do
    lambda{@clock.month = 1}.should raise_error 
  end

  it "has a day variable" do
    @clock.day.should_not be_nil
  end

  it "starts the day at 1" do
    @clock.day.should eql 1
  end

  it "doesn't let you set the day variable" do
    lambda{@clock.day = 1}.should raise_error 
  end

  it "has an hour variable" do
    @clock.hour.should_not be_nil
  end

  it "starts the hour at 0" do
    @clock.hour.should eql 0
  end

  it "doesn't let you set the hour variable" do
    lambda{@clock.hour = 1}.should raise_error 
  end

  it "has a minute variable" do
    @clock.minute.should_not be_nil
  end

  it "starts the minute at 0" do
    @clock.hour.should eql 0
  end

  it "doesn't let you set the minute variable" do
    lambda{@clock.minute = 1}.should raise_error 
  end

  it "has a getter for the current time" do
    @clock.time.should_not be_nil
  end

  it "should tick and update the minute" do
    start_minute = @clock.minute
    @clock.tick
    @clock.minute.should eql start_minute+1
  end

  it "should update the hour for every 60 ticks" do
    start_hour = @clock.hour
    60.times do
      @clock.tick
    end
    @clock.hour.should eql start_hour+1
  end

  it "should set minute back to 0 when updating the hour" do
    60.times do
      @clock.tick
    end
    @clock.minute.should eql 0
  end

  it "should update the day for every 24 hours" do
    start_day = @clock.day
    24.times do
      60.times do
        @clock.tick
      end
    end
    @clock.day.should eql start_day+1
  end

  it "should set the hour back to 0 when it updates the day" do
    24.times do
      60.times do
        @clock.tick
      end
    end
    @clock.hour.should eql 0
  end

  it "should update the month for every 30 days" do
    start_month = @clock.month
    30.times do
      24.times do
        60.times do
          @clock.tick
        end
      end
    end
    @clock.month.should eql start_month+1
  end

  it "should set the day back to 1 when it updates the month" do
    30.times do
      24.times do
        60.times do
          @clock.tick
        end
      end
    end
    @clock.day.should eql 1
  end

  it "should update the year for every 12 months" do
    start_year = @clock.year
    12.times do
      30.times do
        24.times do
          60.times do
            @clock.tick
          end
        end
      end
    end
    @clock.year.should eql start_year+1
  end

  it "should set the month back to 1 when it updates the year" do
    12.times do
      30.times do
        24.times do
          60.times do
            @clock.tick
          end
        end
      end
    end
    @clock.month.should eql 1
  end

end

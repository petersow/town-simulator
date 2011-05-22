require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'yaml'

module Town
  describe Clock do
    before(:each) do
      @clock = Town::Clock.new
    end

    it "has a time variable" do
      @clock.time.should_not be_nil
    end

    it "has a time variable of type Town::Time" do
      @clock.time.should be_is_a Town::Time
    end

    it "should not persist changes to time's variables" do
       @clock.time.day = 8
       @clock.time.day.should_not eql 8
    end

    it "should not let year be set" do
      lambda{@clock.time = Town::Time.new}.should raise_error 
    end

    it "has a year variable" do
      @clock.year.should_not be_nil
    end

    it "starts the year at 1" do
      @clock.year.should eql 1
    end

    it "should not let year be set" do
      lambda{@clock.year = 1}.should raise_error 
    end

    it "has a month variable" do
      @clock.month.should_not be_nil
    end

    it "starts the month at 1" do
      @clock.month.should eql 1
    end

    it "should not let month be set" do
      lambda{@clock.month = 1}.should raise_error 
    end

    it "has a day variable" do
      @clock.day.should_not be_nil
    end

    it "starts the day at 1" do
      @clock.day.should eql 1
    end

    it "should not let day be set" do
      lambda{@clock.day = 1}.should raise_error 
    end

    it "has an hour variable" do
      @clock.hour.should_not be_nil
    end

    it "starts the hour at 0" do
      @clock.hour.should eql 0
    end

    it "should not let hour be set" do
      lambda{@clock.hour = 1}.should raise_error 
    end

    it "has a minute variable" do
      @clock.minute.should_not be_nil
    end

    it "starts the minute at 0" do
      @clock.hour.should eql 0
    end

    it "should not let minute be set" do
      lambda{@clock.minute = 1}.should raise_error 
    end

    it "has overridden to_s" do
      @clock.to_s.should eql "00:00 01/01/1"
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

    context "yaml output" do

      before(:each) do

        23.times do
          60.times do
            @clock.tick
          end
        end

        5.times do
          @clock.tick
        end
        @yaml = YAML::load @clock.to_yaml
      end

      it "should have a to_yaml method" do
        @yaml.should_not be_nil
      end
   
      it "should set class to Clock on the to_yaml output" do
        @yaml['class'].should eql "Clock"
      end

      it "should have an hash of values" do
       @yaml['values'].should be_is_a Hash
       @yaml['values'].should_not be_nil
      end

      it "should have a hash of values with minute set to 5" do
        @yaml['values']['minute'].should eql 5
      end

      it "should have a hash of values with hour set to 23" do
        @yaml['values']['hour'].should eql 23
      end

      it "should have a hash of values with day set to 1" do
        @yaml['values']['day'].should eql 1
      end

      it "should have a hash of values with month set to 1" do
        @yaml['values']['month'].should eql 1
      end

      it "should have a hash of values with year set to 1" do
        @yaml['values']['year'].should eql 1
      end

    end

  end
end

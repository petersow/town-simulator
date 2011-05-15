require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe Runner do

    context "Starting up" do

      before(:each) do
        @messenger = mock(:messenger).as_null_object
        @clock = mock(:clock).as_null_object
        @clock.stub!(:to_s).and_return("00:01 01/01/1")
        @runner = Runner.new(@messenger, @clock, 
                             :seconds_to_run => 1, :sleep_time => 0)
      end

      it "should send a welcome message" do
        @messenger.should_receive(:puts).with("Welcome to the Town!")
        @runner.start
      end

      it "should tick the clock" do
        @clock.should_receive(:tick)
        @runner.start
      end

      it "should tick the clock 5 times for 5 seconds" do
        @runner.seconds_to_run = 5
        @clock.should_receive(:tick).at_least(5).times
        @runner.start
      end

      it "should print the time onto the messenger" do
        @messenger.should_receive(:puts).with("Welcome to the Town!")
        @messenger.should_receive(:puts).with(/00:01 01\/01\/1/)
        @runner.start
      end

      it "should have an array of people" do
        @runner.people.should_not be_nil
      end

    end

  end
end

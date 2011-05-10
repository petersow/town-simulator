require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe Runner do

    context "Starting up" do

      before(:each) do
        @messenger = mock("messenger").as_null_object
        @runner = Runner.new(@messenger)
      end

      it "should send a welcome message" do
        @messenger.should_receive(:puts).with("Welcome to the Town!")
        @runner.start
      end
      
    end

  end
end

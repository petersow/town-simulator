require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe Action do
    before(:each) do
      @action = Town::Action.new
    end

    it "has an a_id" do
      @action.a_id.should_not be_nil
    end

  end
end

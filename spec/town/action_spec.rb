require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe Action do
    before(:each) do
      @action = Town::Action.new
    end

    it "has an a_id" do
      @action.a_id.should_not be_nil
    end

    it "has a unique a_id" do
      actions = []
      1000.times do
        actions << Action.new
      end

      actions.each do |action|
        action.a_id.should_not eql @action.a_id
      end
    end

    it "should not let a_id be set" do
      lambda{@action.a_id = 1}.should raise_error 
    end

    it "should have a name" do
      @action.name.should_not be_nil
    end

    it "should let name be changed" do
      @action.name = "Idle"
      @action.name.should eql "Idle"
    end

    it "should let name be set at creation" do
      action = Action.new(:name => "Running") 
      action.name.should eql "Running"
    end

  end
end

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

    it "should have a type" do
      @action.type.should_not be_nil
    end

    it "should default type to passive" do
      @action.type.should eql "passive"
    end
  
    it "should let type be set to active at creation" do
      active_action = Action.new(:type => "active")
      active_action.type.should eql "active"
    end

    it "should not let type be anything but active or passive at creation" do
      lambda{Action.new(:type => "aaaaaaaa")}.should raise_error 
      lambda{Action.new(:type => "")}.should raise_error 
    end
   
    it "should let type be set to passive" do
      lambda{@action.type = "passive"}.should_not raise_error 
      @action.type.should eql "passive"
    end

    it "should let type be set to active" do
      lambda{@action.type = "active"}.should_not raise_error 
      @action.type.should eql "active"
    end

    it "should not let type be anything other than active or passive" do
      lambda{@action.type = "aaaaaaaa"}.should raise_error 
      lambda{@action.type = ""}.should raise_error 
    end

  end
end

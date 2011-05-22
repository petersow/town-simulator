require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town

  describe Person do

    before(:each) do
      @person = Person.new
    end

    it "should be a subclass of Thing" do
      @person.should be_is_a Thing
    end

    it "should have a first name" do
      @person.first_name.should_not be_nil
    end

    it "should let first name be changed" do
      @person.first_name = "Frank"
      @person.first_name.should eql "Frank"
    end

    it "should let first name be set at creation" do
      george = Person.new(:first_name => "Frank") 
      george.first_name.should eql "Frank"
    end

    it "should have a family name" do
      @person.family_name.should_not be_nil
    end

    it "should let family name be changed" do
      @person.family_name = "Smith"
      @person.family_name.should eql "Smith"
    end

    it "should let family name be set at creation" do
      mr_x = Person.new(:family_name => "X") 
      mr_x.family_name.should eql "X"
    end

    it "should have a date of birth" do
      @person.date_of_birth.should_not be_nil
    end

    it "should have a date of birth that is of type Town::Time.new" do
      @person.date_of_birth.should be_is_a Town::Time
    end

    it "should have a bedtime_hour" do
      @person.bedtime_hour.should_not be_nil
    end

    it "should default bedtime_hour to 23" do
      @person.bedtime_hour.should eql 23
    end

    it "should let bedtime_hour be changed" do
      @person.bedtime_hour = 12
      @person.bedtime_hour.should eql 12
    end

    it "should check bedtime_hour is <= 23" do
      lambda{@person.bedtime_hour = 24}.should raise_error ArgumentError
    end

    it "should check bedtime_hour is >= 0" do
      lambda{@person.bedtime_hour = -1}.should raise_error ArgumentError
    end

    it "should let bedtime be set at creation" do
      all_nighter = Person.new(:bedtime_hour => 5)
      all_nighter.bedtime_hour.should eql 5
    end

    it "should check bedtime_hour is >= 0 at creation" do
      lambda{Person.new(:bedtime_hour => -2)}.should raise_error ArgumentError
    end

    it "should check bedtime_hour is <= 23 at creation" do
      lambda{Person.new(:bedtime_hour => 25)}.should raise_error ArgumentError
    end

    it "should have a wake_up_hour" do
      @person.wake_up_hour.should_not be_nil
    end

    it "should default wake_up_hour to 7" do
      @person.wake_up_hour.should eql 7
    end

    it "should let wake_up_hour be changed" do
      @person.wake_up_hour = 12
      @person.wake_up_hour.should eql 12
    end

    it "should check wake_up_hour is <= 23" do
      lambda{@person.wake_up_hour = 24}.should raise_error ArgumentError
    end

    it "should check wake_up_hour is >= 0" do
      lambda{@person.wake_up_hour = -1}.should raise_error ArgumentError
    end

    it "should let wake_up_hour be set at creation" do
      early_riser = Person.new(:wake_up_hour => 5)
      early_riser.wake_up_hour.should eql 5
    end

    it "should check wake_up_hour is >= 0 at creation" do
      lambda{Person.new(:wake_up_hour => -2)}.should raise_error ArgumentError
    end

    it "should check wake_up_hour is <= 23 at creation" do
      lambda{Person.new(:wake_up_hour => 25)}.should raise_error ArgumentError
    end

    context "yaml output" do
    
      before(:each) do
        @person.first_name = "Yaml"
        @person.family_name = "Test"
        @yaml = YAML::load @person.to_yaml
      end

      it "should have a to_yaml method" do
        @person.to_yaml.should_not be_nil
      end

      it "should set class to Person on the to_yaml output" do
        @yaml['class'].should eql "Person"
      end

      it "should have an id which is the t_id" do
        @yaml['id'].should eql @person.t_id
      end

      it "should have a hash of values" do
       @yaml['values'].should be_is_a Hash
       @yaml['values'].should_not be_nil
      end

      it "should have a hash of values with first name set to Yaml" do
        @yaml['values']['first_name'].should eql "Yaml"
      end

      it "should have a hash of values with first name set to Test" do
        @yaml['values']['family_name'].should eql "Test"
      end

      it "should have a hash of values with date of birth set to 00:00 01/01/1" do
        @yaml['values']['date_of_birth'].should eql "00:00 01/01/1"
      end

    end

  end
end

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

  end
end

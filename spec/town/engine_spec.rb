require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe Engine do

    context "people config for 1 person" do

      before(:each) do
        @people_config = YAML::load(File.open('spec/fixtures/one_person.yaml'))
        @engine = Engine.new(:people_config => @people_config)
        @person = @engine.people.first
      end

      it "should let me pass in a person config array" do
        lambda{Engine.new(:people_config => @people_config)}.should_not raise_error
      end
    
      it "should have 1 person" do
        @engine.people.size.should eql 1
      end

      it "should have a person with the name Stick" do
        @person.first_name.should eql "Stick"
      end

      it "should have a person with the family name Boy" do
        @person.family_name.should eql "Boy"
      end

      it "should have a person with the bedtime hour of 22" do
        @person.bedtime_hour.should eql 22
      end

      it "should have a person with the wake up hour of 8" do
        @person.wake_up_hour.should eql 8
      end
    end

    context "people config for 2 people" do
      before(:each) do
        @people_config = YAML::load(File.open('spec/fixtures/two_people.yaml'))
        @engine = Engine.new(:people_config => @people_config)
      end
    
      it "should have 2 people" do
        @engine.people.size.should eql 2
      end

      it "should have different family names" do
        @engine.people.first.family_name.should_not eql @engine.people.last.family_name
      end
    end

    context "place config for 1 place" do

      before(:each) do
        @places_config = YAML::load(File.open('spec/fixtures/one_place.yaml'))
        @engine = Engine.new(:places_config => @places_config)
        @place = @engine.places.first
      end

      it "should let me pass in a place config array" do
        lambda{Engine.new(:places_config => @places_config)}.should_not raise_error
      end
    
      it "should have 1 place" do
        @engine.places.size.should eql 1
      end

      it "should have a place with the name Farm" do
        @place.name.should eql "Farm"
      end

      it "should have a place with a location" do
        @place.location.should_not be_nil
      end

      it "should have a place with a location with an x of 20" do
        @place.location.x.should eql 20
      end

      it "should have a place with a location with a y of 0" do
        @place.location.y.should eql 0
      end

      it "should have a place with a location with a z of 30" do
        @place.location.z.should eql 30
      end
    end

    context "Starting up" do

      before(:each) do
        @messenger = mock(:messenger).as_null_object
        @clock = mock(:clock).as_null_object
        @clock.stub!(:to_s).and_return("00:01 01/01/1")
        @engine = Engine.new(:messenger => @messenger, :clock => @clock, 
                             :seconds_to_run => 1, :sleep_time => 0)
      end

      it "should send a welcome message" do
        @messenger.should_receive(:puts).with("Welcome to the Town!")
        @engine.start
      end

      it "should tick the clock" do
        @clock.should_receive(:tick)
        @engine.start
      end

      it "should tick the clock 5 times for 5 seconds" do
        @engine.seconds_to_run = 5
        @clock.should_receive(:tick).at_least(5).times
        @engine.start
      end

      it "should print the time onto the messenger" do
        @messenger.should_receive(:puts).with("Welcome to the Town!")
        @messenger.should_receive(:puts).with(/00:01 01\/01\/1/)
        @engine.start
      end

      it "should have an array of places" do
        @engine.places.should_not be_nil
      end
    end

    context "job role config for 1 job role" do

      before(:each) do
        @places_config = YAML::load(File.open('spec/fixtures/one_place.yaml'))
        @job_roles_config = YAML::load(File.open('spec/fixtures/one_job_role.yaml'))

        @engine = Engine.new(:places_config => @places_config,
                             :job_roles_config => @job_roles_config)
        @job_role = @engine.job_roles.first
      end

      it "should let me pass in a job role config array" do
        lambda{Engine.new(:job_roles_config => @job_roles_config)}.should_not raise_error
      end
    
      it "should have 1 job role" do
        @engine.job_roles.size.should eql 1
      end

      it "should have a job role with the name Farmer" do
        @job_role.name.should eql "Farmer"
      end

      it "should have a job role with the start hour of 5" do
        @job_role.start_hour.should eql 5
      end

      it "should have a job role with the end hour of 5" do
        @job_role.end_hour.should eql 15
      end

      it "should have a job role with the place of Farm" do
        @job_role.place.should eql @engine.places.first
      end
    end

    context "people config for 1 person with a job" do

      before(:each) do
        @places_config = YAML::load(File.open('spec/fixtures/one_place.yaml'))
        @job_roles_config = YAML::load(File.open('spec/fixtures/one_job_role.yaml'))
        @people_config = YAML::load(File.open('spec/fixtures/one_farmer.yaml'))
        @engine = Engine.new(:people_config => @people_config,
                             :places_config => @places_config,
                             :job_roles_config => @job_roles_config)
        @person = @engine.people.first
      end

      it "should have 1 person" do
        @engine.people.size.should eql 1
      end

      it "should have a person with the job of farmer" do
        @person.job.should eql @engine.job_roles.first
      end
    end

    context "people config for 1 person with a home" do

      before(:each) do
        @places_config = YAML::load(File.open('spec/fixtures/one_home.yaml'))
        @people_config = YAML::load(File.open('spec/fixtures/one_home_owner.yaml'))
        @engine = Engine.new(:people_config => @people_config,
                             :places_config => @places_config)
        @person = @engine.people.first
      end

      it "should have 1 person" do
        @engine.people.size.should eql 1
      end

      it "should have a person with the home of home one" do
        @person.home.should eql @engine.places.first
      end
    end

  end
end

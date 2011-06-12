require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module Town
  describe WorkAction do

    before(:each) do
      @place = Place.new(:name => "School")
      @job_role = JobRole.new(:name => "Teacher",
                              :place => @place)
      @work_action = WorkAction.new(:job_role => @job_role)
    end

    it "should be a subclass of Action" do
      @work_action.should be_is_a Action
    end

    it "should have a name of Work" do
      @work_action.name.should eql "Work"
    end

    it "should have a type of passive" do
      @work_action.type.should eql "passive"
    end

    it "should return true for is_finished?" do
      @work_action.should be_is_finished
    end

    it "should have a job_role" do
      @work_action.job_role.should_not be_nil
    end

    it "should have a to_s of Working at {place}" do
      @work_action.to_s.should eql "Working at #{@job_role.place.name}"
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Town
  describe JobRole do
    before(:each) do
      @job_role = Town::JobRole.new
    end

    it "has a j_id" do
      @job_role.j_id.should_not be_nil
    end

    it "has a unique j_id" do
      job_roles = []
      1000.times do
        job_roles << JobRole.new
      end

      job_roles.each do |job_role|
        job_role.j_id.should_not eql @job_role.j_id
      end
    end

    it "should not let j_id be set" do
      lambda{@job_role.j_id = 1}.should raise_error 
    end

    it "should have a name" do
      @job_role.name.should_not be_nil
    end

    it "should let name be changed" do
      @job_role.name = "Forester"
      @job_role.name.should eql "Forester"
    end

    it "should let name be set at creation" do
      job_role = JobRole.new(:name => "Fisher") 
      job_role.name.should eql "Fisher"
    end

    it "should have a start hour" do
      @job_role.start_hour.should_not be_nil
    end

    it "should default start hour to 9" do
      @job_role.start_hour.should eql 9
    end

    it "should let start hour be changed" do
      @job_role.start_hour = 19
      @job_role.start_hour.should eql 19
    end

    it "should let name be set at creation" do
      job_role = JobRole.new(:start_hour => 10) 
      job_role.start_hour.should eql 10
    end

    it "should have a end hour" do
      @job_role.end_hour.should_not be_nil
    end

    it "should default end hour to 17" do
      @job_role.end_hour.should eql 17
    end

    it "should let end hour be changed" do
      @job_role.end_hour = 19
      @job_role.end_hour.should eql 19
    end

    it "should let name be set at creation" do
      job_role = JobRole.new(:end_hour => 10) 
      job_role.end_hour.should eql 10
    end



  end
end

module Town
  class WorkAction < Action

    attr_accessor :job_role

    def initialize(options = {})
      super(:name => "Work",
            :type => "passive")
      @job_role = options[:job_role] || nil
    end

    def to_s
      "Working at #{@job_role.place.name}"
    end

    def is_finished?
      true
    end

    def step
      if @job_role.is_a? Town::WoodCuttingJob or 
         @job_role.is_a? Town::SawyerJob or
         @job_role.is_a? Town::CarpenteryJob
        @job_role.step
      end
    end

  end
end

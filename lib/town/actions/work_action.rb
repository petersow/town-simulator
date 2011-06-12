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

  end
end

module Town
  class WorkAction < Action

    def initialize
      super(:name => "Work",
            :type => "passive")
    end

    def to_s
      "Working"
    end

    def is_finished?
      true
    end

  end
end

module Town
  class SleepAction < Action

    def initialize
      super(:name => "Sleep",
            :type => "passive")
    end

    def to_s 
      "Sleeping"
    end
  end
end

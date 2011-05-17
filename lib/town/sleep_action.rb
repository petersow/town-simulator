module Town
  class SleepAction < Action

    def initialize
      super(:name => "Sleep",
            :type => "passive")
    end

    def to_s 
      "Sleeping"
    end

    def is_finished?
      # If thing is a person and its his awake time then you're finished
      return false
    end

  end
end

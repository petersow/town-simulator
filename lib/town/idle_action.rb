module Town
  class IdleAction < Action

    def initialize
      super(:name => "Idle",
            :type => "passive")
    end

    def to_s
      "Idle"
    end

    def is_finished?
      true
    end

    def next_action(thing)
      if thing.is_a? Person
        # If thing is a person and its past his bedtime and hes home
#        if thing.
        return SleepAction.new
      end
      self
    end
  end
end

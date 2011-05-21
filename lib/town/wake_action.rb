module Town
  class WakeAction < Action
 
    attr_accessor :time_remaining

    def initialize
      super(:name => "Wake",
            :type => "passive")
      @time_remaining = 5
    end

    def to_s
      "Waking up"
    end

    def step
      @time_remaining -= 1
    end

    def is_finished?
      return @time_remaining <= 0
    end

  end
end

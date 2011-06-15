module Town
  class ChopTreeAction < Action

    attr_accessor :time_remaining

    def initialize(options = {})
      super(:name => "Chop Tree",
            :type => "active")
      @time_remaining = 30
    end

    def to_s
      "Chopping down a tree"
    end

    def step
      @time_remaining -= 1
    end

    def is_finished?
      return @time_remaining <= 0
    end

  end
end

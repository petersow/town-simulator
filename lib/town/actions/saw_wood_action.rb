module Town
  class SawWoodAction < Action
  
    attr_accessor :time_remaining

    def initialize(options = {})
      super(:name => "Saw wood",
            :type => "active")
      @time_remaining = 45
    end

    def to_s
      "Sawing wood"
    end

    def step
      @time_remaining -= 1
    end

    def is_finished?
      return @time_remaining <= 0
    end
  end
end

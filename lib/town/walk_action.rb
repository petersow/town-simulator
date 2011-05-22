module Town
  class WalkAction < Action

    attr_accessor :start_location, :end_location, :time_remaining

    def initialize(options = {})
      super(:name => "Walk",
            :type => "active")
      @start_location = options[:start_location] ||= "Nowhere"
      @end_location = options[:end_location] ||= "Nowhere"

      @time_remaining = 59
    end

    def to_s
      "Walking to #{@end_location}"
    end

    def step
      @time_remaining -= 1
    end

    def is_finished?
      return @time_remaining <= 0
    end

  end
end

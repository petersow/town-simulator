module Town
  class EatAction < Action

    attr_accessor :meal_name, :time_remaining

    def initialize(options = {})
      super(:name => "Eat",
            :type => "active")
      @meal_name = options[:meal_name] ||= "Snack"
      @time_remaining = 20
    end

    def to_s
      "Eating #{@meal_name}"
    end

    def step
      @time_remaining -= 1
    end

    def is_finished?
      return @time_remaining <= 0
    end

  end
end

module Town
  class EatAction < Action

    attr_accessor :meal_name

    def initialize(options = {})
      super(:name => "Eat",
            :type => "passive")
      @meal_name = options[:meal_name] ||= "Snack"
    end

    def to_s
      "Eating #{@meal_name}"
    end

    def is_finished?
      true
    end

  end
end

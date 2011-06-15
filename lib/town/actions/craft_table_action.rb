module Town
  class CraftTableAction < Action
    attr_accessor :time_remaining

    def initialize(options = {})
      super(:name => "Craft Table",
            :type => "active")
      @time_remaining = 180
    end

    def to_s
      "Crafting a table"
    end

    def step
      @time_remaining -= 1
    end

    def is_finished?
      return @time_remaining <= 0
    end
  end
end

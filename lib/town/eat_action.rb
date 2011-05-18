module Town
  class EatAction < Action

    def initialize
      super(:name => "Eat",
            :type => "passive")
    end

    def to_s
      "Eating"
    end

    def is_finished?
      true
    end

  end
end

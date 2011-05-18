module Town
  class WalkAction < Action

    def initialize
      super(:name => "Walk",
            :type => "passive")
    end

    def to_s
      "Walking"
    end

    def is_finished?
      true
    end

  end
end

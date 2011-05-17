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

  end
end

module Town
  class WakeAction < Action

    def initialize
      super(:name => "Wake",
            :type => "passive")
    end

    def to_s
      "Waking up"
    end

    def is_finished?
      true
    end

  end
end

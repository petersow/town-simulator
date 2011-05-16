module Town
  class IdleAction < Action

    def initialize
      super(:name => "Idle",
            :type => "passive")
    end
  end
end

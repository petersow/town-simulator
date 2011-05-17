module Town
  class ActionGenerator
  
    attr_accessor :time

    def initialize
      @time = Town::Time.new
    end

    def next_action(thing)
      unless thing.is_a? Thing
        raise ArgumentError
      end
      if thing.is_a? Person
        return IdleAction.new
      end
    end

  end
end

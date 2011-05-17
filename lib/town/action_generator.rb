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
        if @time.hour >= thing.bedtime_hour
          return SleepAction.new
        end
        return IdleAction.new
      end
    end

  end
end

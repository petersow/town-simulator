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
        if thing.current_action.is_a? SleepAction
          if @time.hour >= thing.wake_up_hour
            return WakeAction.new
          end
          return SleepAction.new
        elsif thing.bedtime_hour > thing.wake_up_hour
          if @time.hour >= thing.bedtime_hour or @time.hour < thing.wake_up_hour
            return SleepAction.new
          end
          return IdleAction.new
        elsif thing.bedtime_hour < thing.wake_up_hour
          if @time.hour >= thing.bedtime_hour and @time.hour < thing.wake_up_hour
            return SleepAction.new
          end
          return IdleAction.new
        end
      end
    end

  end
end

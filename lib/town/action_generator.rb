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
        if thing.job 
          if @time.hour >= thing.job.start_hour-1 and @time.hour < thing.job.start_hour
            return WalkAction.new(:end_location => "Work")
          end
          if @time.hour >= thing.job.start_hour and @time.hour < thing.job.end_hour
            return WorkAction.new
          end
        end
        if thing.current_action.is_a? EatAction
          thing.current_action.step
          if thing.current_action.is_finished?
            return IdleAction.new
          else
            return thing.current_action
          end
        elsif thing.current_action.is_a? WakeAction
          thing.current_action.step
          if thing.current_action.is_finished?
            return EatAction.new(:meal_name => "Breakfast")
          else
            return thing.current_action
          end
        elsif thing.current_action.is_a? SleepAction
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

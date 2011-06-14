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
          if thing.current_action.is_a? ActiveWalkAction
            thing.current_action.step
            if thing.current_action.is_finished? 
              if thing.current_action.end_location.eql? thing.job.place
                return WorkAction.new(:job_role => thing.job)
              else
                return EatAction.new(:meal_name => "Dinner")
              end
            end
          end
          if thing.current_action.is_a? WorkAction
            if @time.hour >= thing.job.end_hour and @time.hour < thing.job.end_hour+1
              return ActiveWalkAction.new(:end_location => thing.home, :thing => thing)
            end
            return WorkAction.new(:job_role => thing.job)
          elsif @time.hour >= thing.job.start_hour-1 and @time.hour < thing.job.start_hour
            name = thing.job.place.name
            if thing.should_go_to_work?(@time.minute)
              return ActiveWalkAction.new(:end_location => thing.job.place,
                                          :thing => thing)
            end
          end
        end
        if thing.current_action.is_a? ActiveWalkAction
          if thing.current_action.end_location.eql? "Home" 
            return EatAction.new(:meal_name => "Dinner")
          end
        elsif thing.current_action.is_a? EatAction
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
          if thing.bedtime_hour > thing.wake_up_hour
            if @time.hour >= thing.wake_up_hour and @time.hour < thing.bedtime_hour
              return WakeAction.new
            end
            return SleepAction.new
          else
            if @time.hour >= thing.wake_up_hour
              return WakeAction.new
            end
            return SleepAction.new
          end
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

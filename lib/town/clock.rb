module Town
  class Clock

    YEAR_INIT = 1
    MONTH_INIT = 1 
    DAY_INIT = 1
    HOUR_INIT = 0
    MINUTE_INIT = 0
  
    def initialize
      @time = Town::Time.new
    end

    def year
      @time.year
    end
  
    def month
      @time.month
    end

    def day
      @time.day
    end

    def hour
      @time.hour
    end

    def minute
      @time.minute
    end

    def time
      @time.clone
    end

    def to_s
      "#{pad(hour)}:#{pad(minute)} #{pad(day)}/#{pad(month)}/#{year}"
    end

    def tick
      @time.minute += 1
      if @time.minute > 59
        @time.minute = MINUTE_INIT
        @time.hour += 1
      end
      if @time.hour > 23
        @time.hour = HOUR_INIT
        @time.day += 1
      end
      if @time.day > 30
        @time.day = DAY_INIT
        @time.month += 1
      end
      if @time.month > 12
        @time.month = MONTH_INIT
        @time.year += 1
      end
    end

    protected 

    def pad(time)
      "#{time < 10 ? "0#{time}" : time}"
    end
  end
end

module Town
  class Time
    attr_accessor :year, :month, :day, :hour, :minute

    YEAR_INIT = 1
    MONTH_INIT = 1 
    DAY_INIT = 1
    HOUR_INIT = 0
    MINUTE_INIT = 0

    def initialize(options = {})
      @year = options[:year] ||=  YEAR_INIT
      @month = options[:month] ||= MONTH_INIT
      @day = options[:day] ||= DAY_INIT
      @hour = options[:hour] ||= HOUR_INIT
      @minute = options[:minute] ||=  MINUTE_INIT
    end

    def Time.check_hour(hour)
      if hour > 23 or hour < 0
        raise ArgumentError
      end
      hour
    end

    def to_s
      "#{pad(hour)}:#{pad(minute)} #{pad(day)}/#{pad(month)}/#{year}"
    end

    protected 

    def pad(time)
      "#{time < 10 ? "0#{time}" : time}"
    end

  end
end

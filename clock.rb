class Clock

  attr_reader :year, :month, :day, :hour, :minute
  
  YEAR_INIT = 1
  MONTH_INIT = 1
  DAY_INIT = 1
  HOUR_INIT = 0
  MINUTE_INIT = 0

  def initialize
    @year = YEAR_INIT
    @month = MONTH_INIT
    @day = DAY_INIT
    @hour = HOUR_INIT
    @minute = MINUTE_INIT
  end

  def time 
    "#{pad(hour)}:#{pad(minute)} #{pad(day)}/#{pad(month)}/#{year}"
  end

  def tick
    @minute += 1
    if @minute > 59
      @minute = MINUTE_INIT
      @hour += 1
    end
    if @hour > 23
      @hour = HOUR_INIT
      @day += 1
    end
    if @day > 30
      @day = DAY_INIT
      @month += 1
    end
    if @month > 12
      @month = MONTH_INIT
      @year += 1
    end
  end

  protected 

  def pad(time)
    "#{time < 10 ? "0#{time}" : time}"
  end

end

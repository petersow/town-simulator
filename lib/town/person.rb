module Town
  class Person < Thing
    attr_accessor :first_name, :family_name, :bedtime_hour, :wake_up_hour
    attr_reader :date_of_birth
   
    def initialize(options = {})
      super(options)
      @first_name = options[:first_name] ||= ""
      @family_name = options[:family_name] ||= ""
      @date_of_birth = options[:date_of_birth] ||= Town::Time.new
      self.bedtime_hour=(options[:bedtime_hour] ||= 23)
      self.wake_up_hour=(options[:wake_up_hour] ||= 7)
    end

    def bedtime_hour=(hour)
      @bedtime_hour = Time.check_hour(hour)
    end

    def wake_up_hour=(hour)
      @wake_up_hour = Time.check_hour(hour)
    end

  end
end

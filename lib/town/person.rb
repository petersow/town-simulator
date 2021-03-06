module Town
  class Person < Thing
    attr_accessor :first_name, :family_name, :bedtime_hour
    attr_accessor :wake_up_hour, :job, :home, :inventory
    attr_reader :date_of_birth
   
    def initialize(options = {})
      super(options)
      @first_name = options[:first_name] ||= ""
      @family_name = options[:family_name] ||= ""
      @date_of_birth = options[:date_of_birth] ||= Town::Time.new
      @inventory = Inventory.new
      # Self used because @ doesn't throw the exception
      self.bedtime_hour=(options[:bedtime_hour] ||= 23)
      self.wake_up_hour=(options[:wake_up_hour] ||= 7)
    end

    def bedtime_hour=(hour)
      @bedtime_hour = Time.check_hour(hour)
    end

    def wake_up_hour=(hour)
      @wake_up_hour = Time.check_hour(hour)
    end

    def should_go_to_work?(mins)
      # find distance from home to work
      time_to_travel = @location.distance(job.place.location)
      # look at time, if no time left then go
      if 60.to_i-mins > time_to_travel
        false
      else
        true
      end
      # if time left then 20% chance to go early per tick
    end

    def to_yaml
      out = {}
      out['class'] = "Person"
      out['id'] = self.t_id
      values = {}
      values['first_name'] = @first_name
      values['family_name'] = @family_name
      values['date_of_birth'] = @date_of_birth.to_s
      values['current_action'] = @current_action.to_s
      out['values'] = values
      out.to_yaml
    end
  end
end

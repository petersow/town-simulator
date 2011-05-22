require 'town/clock'

module Town
  class Engine

    attr_accessor :seconds_to_run
    attr_reader :people, :clock

    FOREVER = -1

    def initialize(options = {})
      @messenger = options[:messenger]
      @clock = options[:clock] ||= Clock.new
      @seconds_to_run = options[:seconds_to_run] ||= FOREVER
      @options = options
   
      @people = []

      if options[:people_config]
        options[:people_config].each_value do |person|
          new_person = Person.new
          person.each_pair do |key, value|
            #Date of birth isnt allowed to be set
            begin 
              new_person.send "#{key}=", value
            rescue
            end
          end
          @people << new_person
        end
      else 
        @people << Person.new(:first_name => "Pete",
                              :family_name => "Sowerbutts",
                              :bedtime_hour => 1)
        @people.first.job = JobRole.new(:name => "Fisher")
      end

      @action_generator = ActionGenerator.new
      @options[:sleep_time] = 0.05
      @options[:output_format] = options[:output_format] ||= "text"

    end 
 
    def start 
      @messenger.puts "Welcome to the Town!"

      while not @seconds_to_run.eql?(0) do
        @clock.tick
        @action_generator.time = @clock.time
        if @options[:output_format].eql? "yaml"
          @messenger.puts @clock.to_yaml
        else
          @messenger.puts "#{@clock}\n"
        end

        @people.each do |person|
          person.current_action = @action_generator.next_action(person)
          @messenger.puts "#{person.first_name} #{person.family_name} is at " +
                          "(#{person.location.x},#{person.location.y}," +
                          "#{person.location.z})"
          @messenger.puts "#{person.first_name} #{person.family_name} is #{person.current_action}."
        end

	sleep @options[:sleep_time] ||= 1
        unless @seconds_to_run.eql?(FOREVER)
          @seconds_to_run -= 1
        end
      end
    end
  end
end

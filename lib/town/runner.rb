require 'town/clock'

module Town
  class Runner

    attr_accessor :seconds_to_run
    attr_reader :people

    FOREVER = -1

    def initialize(messenger, clock = Clock.new, options = {})
      @messenger = messenger
      @clock = clock
      @seconds_to_run = options[:seconds_to_run] ||= FOREVER
      @options = options
   
      @people = []

      @people << Person.new(:first_name => "Pete",
                            :family_name => "Sowerbutts")
    end 
 
    def start 
      @messenger.puts "Welcome to the Town!"

      while not @seconds_to_run.eql?(0) do
        @clock.tick
        @messenger.puts "#{@clock.to_s}\n"

        @people.each do |person|
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

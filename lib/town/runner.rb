require 'town/clock'

module Town
  class Runner

    attr_accessor :seconds_to_run

    FOREVER = -1

    def initialize(messenger, clock = Clock.new, options = {})
      @messenger = messenger
      @clock = clock
      @seconds_to_run = options[:seconds_to_run] ||= FOREVER
      @options = options
    end 
 
    def start 
      @messenger.puts "Welcome to the Town!"

      while not @seconds_to_run.eql?(0) do
        @clock.tick
        @messenger.puts "#{@clock.time}\n"
	sleep @options[:sleep_time] ||= 1
        unless @seconds_to_run.eql?(FOREVER)
          @seconds_to_run -= 1
        end
      end
    end
  end
end

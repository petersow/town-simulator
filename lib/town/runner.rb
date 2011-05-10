require 'town/clock'

module Town
  class Runner

    def initialize(messenger)
      @messenger = messenger
      @clock = Clock.new
    end 
 
    def start 
      @messenger.puts "Welcome to the Town!"
      
#
#      while true do
#        clock.tick
#        print "#{clock.time}\n"
#        sleep 1
#      end
    end
  end
end

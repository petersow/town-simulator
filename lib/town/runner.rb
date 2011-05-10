require 'town/clock'

module Town
  class Runner
    def start 
      clock = Clock.new

      while true do
        clock.tick
        print "#{clock.time}\n"
        sleep 1
      end
    end
  end
end

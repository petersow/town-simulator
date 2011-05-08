require 'clock'

clock = Clock.new

while true do
  clock.tick
  print "#{clock.time}\n"
  sleep 1
end

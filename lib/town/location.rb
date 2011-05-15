class Location

  attr_accessor :x, :y, :z

  def initialize(options = {})
    @x = options[:x] ||= 0
    @y = options[:y] ||= 0
    @z = options[:z] ||= 0
  end

end

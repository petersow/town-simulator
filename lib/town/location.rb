module Town
  class Location
    attr_accessor :x, :y, :z

    def initialize(options = {})
      @x = options[:x] ||= 0
      @y = options[:y] ||= 0
      @z = options[:z] ||= 0
    end

    def distance(other)
      x = distance_i(@x, other.x) 
      y = distance_i(@z, other.z) 
      z = distance_i(@z, other.z) 

      result = x
      if y > result
        result = y
      end
      if z > result
        result = z
      end
      return result
    end

    def distance_i(a, b)
      c = a - b 
      if c < 0
        c = c * -1
      end
      c
    end

    def eql?(other)
      unless other.is_a? Town::Location
        return false
      end
      unless other.x.eql? @x
        return false
      end
      unless other.y.eql? @y
        return false
      end
      unless other.z.eql? @z
        return false
      end
      true
    end
  end
end

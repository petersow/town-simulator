module Town
  class Location
    attr_accessor :x, :y, :z

    def initialize(options = {})
      @x = options[:x] ||= 0
      @y = options[:y] ||= 0
      @z = options[:z] ||= 0
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

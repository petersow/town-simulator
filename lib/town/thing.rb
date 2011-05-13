module Town
  class Thing
    attr_reader :t_id
    attr_accessor :location

    def initialize
      @t_id = SecureRandom.uuid
      @location = Location.new
    end

  end
end

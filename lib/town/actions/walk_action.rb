module Town
  class WalkAction < Action

    attr_accessor :start_location, :end_location, :time_remaining

    def initialize(options = {})
      super(:name => "Walk",
            :type => "active")
      @start_location = options[:start_location] ||= "Nowhere"
      @end_location = options[:end_location] ||= "Nowhere"
      @thing = options[:thing]
    end

    def to_s
      "Walking to #{@end_location.name}"
    end

    # Simple to start with, can move 1 in each direction every step
    def step
      ["x","y","z"].each do |loc|
        sym = "@#{loc}".to_sym
        thing = @thing.location.instance_variable_get(sym)
        end_point = @end_location.location.instance_variable_get(sym)
        if thing < end_point
          @thing.location.instance_variable_set(sym, thing+1)
        elsif thing > end_point
          @thing.location.instance_variable_set(sym, thing-1)
        end
      end
    end

    def is_finished?
      return @thing.location.eql? @end_location.location
    end

  end
end

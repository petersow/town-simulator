require 'securerandom'

module Town
  class Thing
    attr_reader :t_id
    attr_accessor :location, :current_action

    def initialize(options = {})
      @t_id = SecureRandom.uuid
      @location = options[:location] ||= Location.new
      # Need to change to a lookup so they all use the same object
      @current_action = Action.new(:name => "Idle")
    end

  end
end

require 'securerandom'

module Town
  class Thing
    attr_reader :t_id
    attr_accessor :location, :current_action

    def initialize(options = {})
      @t_id = SecureRandom.uuid
      @location = options[:location] ||= Location.new
      @current_action = IdleAction.new
    end

  end
end

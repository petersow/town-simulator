require 'securerandom'

module Town
  class Thing
    attr_reader :t_id
    attr_accessor :location

    def initialize(options = {})
      @t_id = SecureRandom.uuid
      @location = options[:location] ||= Location.new
    end

  end
end

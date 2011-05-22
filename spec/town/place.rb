require 'securerandom'

module Town
  class Place
    attr_accessor :name
    attr_reader :p_id

    def initialize(options = {})
      @p_id = SecureRandom.uuid
      @name = options[:name] ||= ""
    end
  end
end

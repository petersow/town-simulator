require 'securerandom'

module Town
  class Place
    attr_accessor :name, :location, :inventory
    attr_reader :p_id

    def initialize(options = {})
      @p_id = SecureRandom.uuid
      @name = options[:name] ||= ""
      @location = options[:location] ||= Location.new
      @inventory = Inventory.new
    end
  end
end

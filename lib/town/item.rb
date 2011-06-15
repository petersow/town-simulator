require 'securerandom'

module Town
  class Item
    attr_reader :i_id
    attr_accessor :name

    def initialize(options = {})
      @i_id = SecureRandom.uuid
      @name = options[:name] ||= ""
    end

  end
end

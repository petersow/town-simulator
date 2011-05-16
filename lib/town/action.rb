require 'securerandom'

module Town
  class Action
    attr_accessor :name
    attr_reader :a_id

    def initialize(options = {})
      @a_id = SecureRandom.uuid
      @name = options[:name] ||= ""
    end
  end
end

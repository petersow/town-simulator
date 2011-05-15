require 'securerandom'

module Town
  class Action
    attr_reader :a_id

    def initialize
      @a_id = SecureRandom.uuid
    end
  end
end

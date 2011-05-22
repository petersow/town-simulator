require 'securerandom'

module Town
  class JobRole
    attr_accessor :name, :start_hour
    attr_reader :j_id

    def initialize(options = {})
      @j_id = SecureRandom.uuid
      @name = options[:name] ||= ""
      @start_hour = options[:start_hour] ||= 9
    end
  end
end

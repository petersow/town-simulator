require 'securerandom'

module Town
  class JobRole
    attr_accessor :name, :start_hour, :end_hour, :place
    attr_reader :j_id

    def initialize(options = {})
      @j_id = SecureRandom.uuid
      @name = options[:name] ||= ""
      @start_hour = options[:start_hour] ||= 9
      @end_hour = options[:end_hour] ||= 17
      @place = options[:place]
    end

  end
end

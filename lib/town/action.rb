require 'securerandom'

module Town
  class Action
    attr_accessor :name, :type
    attr_reader :a_id

    def initialize(options = {})
      @a_id = SecureRandom.uuid
      @name = options[:name] ||= ""
      if options[:type] 
        @type = check_type(options[:type])
      else
        @type = "passive"
      end
    end

    def type=(type)
      @type = check_type(type)
    end

    def is_finished?
      raise NotImplementedError 
    end

    def next_action(thing)
      raise NotImplementedError 
    end


    protected

    def check_type(type)
      unless type.eql?("passive") or type.eql?("active")
        raise InvalidValue
      end
      type
    end

  end
end

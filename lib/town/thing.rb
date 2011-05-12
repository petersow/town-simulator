module Town
  class Thing
    attr_reader :t_id

    def initialize
      @t_id = SecureRandom.uuid
    end

  end
end

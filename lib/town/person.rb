module Town
  class Person < Thing
    attr_accessor :first_name, :family_name, :date_of_birth
   
    def initialize(options = {})
      super(options)
      @first_name = options[:first_name] ||= ""
      @family_name = options[:family_name] ||= ""
      @date_of_birth = 0
    end

  end
end

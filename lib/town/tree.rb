
module Town
  class Tree < Thing

    def initialize(options = {})
      super(options)
      @name = "Tree"
    end

    def name
      "Tree"
    end

  end
end

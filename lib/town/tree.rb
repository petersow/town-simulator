
module Town
  class Tree < Thing

    def initalize(options = {})
      super(options)
      @name = "Tree"
    end

    def name
      "Tree"
    end

  end
end

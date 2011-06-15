module Town
  class Inventory
 
    def initialize
      @contents = {}
    end

    def add(item)
      if @contents.has_key? item.name
        @contents[item.name] = @contents[item.name]+1
      else
        @contents[item.name] = 1
      end
    end

    def remove(item, number)
      if @contents.has_key? item.name
        @contents[item.name] = @contents[item.name]-number
        if @contents[item.name] <= 0
          @contents.delete item.name
        end
      end
    end

    def number_of(item)
      if @contents.has_key? item.name
        return @contents[item.name]
      else
        return 0
      end
    end

    def include?(item)
      return number_of(item) > 0 ? true : false
    end

    def list
      result = ""
      @contents.each {|key, value| result += "#{key} is #{value}\n" }
      return result
    end

  end
end

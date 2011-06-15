module Town
  class BuyItemAction < Action

    def initialize(options = {})
      super(:name => "Buy item",
            :type => "active")
      @item = options[:item]
      @pickup = options[:pickup]
      @deliver = options[:deliver]
      @person = options[:person]
      @number_of = options[:number_of]
      @task = WalkAction.new(:end_location => @pickup,
                             :thing => @person)
      @finished = false
    end

    def step
      @task.step

      if @task.is_finished?
        if @task.is_a? WalkAction and @task.end_location.eql? @pickup
          #Pickup item
          if @pickup.inventory.number_of(@item) >= @number_of
            @pickup.inventory.remove(@item, @number_of)
            @person.inventory.add @item
          end
          if @person.inventory.include? @item
            @task = WalkAction.new(:end_location => @deliver,
                                   :thing => @person)
          end
        elsif @task.is_a? WalkAction and @task.end_location.eql? @deliver
          @finished = true
          if @person.inventory.include? @item
            @person.inventory.remove(@item, @number_of)
            @number_of.times do
              @deliver.inventory.add @item
            end
          end
        end
      end
    end

    def is_finished?
      return @finished
    end

  end
end

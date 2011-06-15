module Town

  class CarpenteryJob < JobRole
    attr_accessor :person, :lumber_mill

    def initalize(options = {})
      super(options)
      @lumber_mill = options[:lumber_mill] ||= []
      @person = options[:person]

      @task = nil
    end

    def step
      @plank = Item.new(:name => "Plank")
      @table = Item.new(:name => "Table")

      if @task
        @task.step
        if @task.is_finished?
          if @task.is_a? CraftTableAction
            @place.inventory.add @table
          end
          @task = nil
        end
      else
        log_count = 0
        # Check for materials
        log_count = @place.inventory.number_of(@plank)

        if log_count >= 4
          @place.inventory.remove(@plank, 4)
          @task = CraftTableAction.new
        else
          # Need some pick up/buy action
          @task = BuyItemAction.new(:item => @plank, :pickup => @lumber_mill,
                                    :deliver => @place, :person => @person,
                                    :number_of => 4-log_count)
        end
      end
    end
  end
end

module Town
  class SawyerJob < JobRole

    attr_accessor :person, :foresters_hut

    def initialize(context, options = {})
      super(options)
      @items = context[:items]

      @person = options[:person]
      @foresters_hut = options[:foresters_hut]
      @task = nil
    end

    def step
      if @task
        @task.step

        if @task.is_finished?
          if @task.is_a? SawWoodAction
            @place.inventory.add @items[:plank]
          end
          @task = nil
        end
      else
        # Check for materials
        mats = false
        if @place.inventory.number_of(@items[:wood_log]) >= 1
          mats = true 
        end

        if mats
          @task = SawWoodAction.new
          @place.inventory.remove(@items[:wood_log], 1)
        else
          @task = BuyItemAction.new(:item => @items[:wood_log], :pickup => @foresters_hut,
                                    :deliver => @place, :person => @person,
                                    :number_of => 1)
        end
      end
    end
  end
end

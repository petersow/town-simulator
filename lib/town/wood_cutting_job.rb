require 'helpers/world_helper'

module Town
  class WoodCuttingJob < JobRole

    attr_accessor :trees, :person

    def initialize(context, options = {})
      super(options)
      @items = context[:items] 

      @trees = options[:trees] ||= []
      @person = options[:person]
      @task = nil
    end

    def step 
      if @task
        @task.step

        if @task.is_finished?
          if @task.is_a? WalkAction and @task.end_location.eql? @tree
            @task = ChopTreeAction.new
          elsif @task.is_a? WalkAction and @task.end_location.eql? @place
            if @person.inventory.include? @items[:wood_log]
              @person.inventory.remove(@items[:wood_log], 1)
              @place.inventory.add @items[:wood_log]
            end
            @task = WalkAction.new(:end_location => @tree,
                                   :thing => @person)
 
          elsif @task.is_a? ChopTreeAction
            # Should really make the action create this item
            @person.inventory.add @items[:wood_log]
            @task = WalkAction.new(:end_location => @place,
                                   :thing => @person)
          else
            @task = nil
          end
        end
      else
        @tree = WorldHelper.find_nearest_tree(@person, @trees)
        @task = WalkAction.new(:end_location => @tree,
                               :thing => @person)
      end
    end

  end
end

require 'helpers/world_helper'

module Town
  class WoodCuttingJob < JobRole

    attr_accessor :trees, :person

    def initalize(options = {})
      super(options)
      @trees = options[:trees] ||= []
      @person = options[:person]
      @task = nil
    end

    def step 
      @wood_log = Item.new(:name => "Wood log")

      if @task
        @task.step

        if @task.is_finished?
          if @task.is_a? WalkAction and @task.end_location.eql? @tree
            @task = ChopTreeAction.new
          elsif @task.is_a? WalkAction and @task.end_location.eql? @place
            if @person.inventory.include? @wood_log
              @person.inventory.remove(@wood_log, 1)
              @place.inventory.add @wood_log
            end
            @task = WalkAction.new(:end_location => @tree,
                                   :thing => @person)
 
          elsif @task.is_a? ChopTreeAction
            # Should really make the action create this item
            @person.inventory.add @wood_log
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

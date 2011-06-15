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
      if @task
        @task.step

        if @task.is_finished?
          if @task.is_a? ActiveWalkAction and @task.end_location.eql? @tree
            @task = ChopTreeAction.new
          elsif @task.is_a? ActiveWalkAction and @task.end_location.eql? @place
            @person.inventory.each do |item|
              if item.name.eql? "Wood log"
                @person.inventory.delete item
                @place.inventory << item
              end
            end
            @task = ActiveWalkAction.new(:end_location => @tree,
                                         :thing => @person)
 
          elsif @task.is_a? ChopTreeAction
            # Should really make the action create this item
            @person.inventory << Item.new(:name => "Wood log")
            @task = ActiveWalkAction.new(:end_location => @place,
                                         :thing => @person)
          else
            @task = nil
          end
        end
      else
        @tree = WorldHelper.find_nearest_tree(@person, @trees)
        @task = ActiveWalkAction.new(:end_location => @tree,
                                     :thing => @person)
      end
    end

  end
end

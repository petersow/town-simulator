require 'helpers/world_helper'

module Town
  class SawyerJob < JobRole

    attr_accessor :person, :foresters_hut

    def initalize(options = {})
      super(options)
      @person = options[:person]
      @foresters_hut = options[:foresters_hut]
      @task = nil
    end

    def step
      @wood_log = Item.new(:name => "Wood log")
      @plank = Item.new(:name => "Plank")

      if @task
        @task.step

        if @task.is_finished?
          if @task.is_a? WalkAction and @task.end_location.eql? @foresters_hut
            #Get a Wood log
            if @foresters_hut.inventory.number_of(@wood_log) >= 1
              @foresters_hut.inventory.remove(@wood_log, 1)
              @person.inventory.add @wood_log
            end
            if @person.inventory.include? @wood_log
              @task = WalkAction.new(:end_location => @place,
                                     :thing => @person)
            end
          elsif @task.is_a? WalkAction and @task.end_location.eql? @place
            if @person.inventory.include? @wood_log
              @person.inventory.remove(@wood_log, 1)
              @place.inventory.add @wood_log
            end
            @task = nil
          elsif @task.is_a? SawWoodAction
            @task = nil
            @place.inventory.add @plank
          end
        end
      else
        # Check for materials
        mats = false
        if @place.inventory.number_of(@wood_log) >= 1
          mats = true 
        end

        if mats
          @task = SawWoodAction.new
          @place.inventory.remove(@wood_log, 1)
        else
          @task = WalkAction.new(:end_location => @foresters_hut,
                                 :thing => @person)
        end
      end
    end
  end
end

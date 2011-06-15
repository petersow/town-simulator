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
      if @task
        @task.step

        if @task.is_finished?
          if @task.is_a? ActiveWalkAction and @task.end_location.eql? @foresters_hut
            #Get a Wood log
            @foresters_hut.inventory.each do |item|
              if item.name.eql? "Wood log"
                @foresters_hut.inventory.delete item
                @person.inventory << item
                break
              end
            end
            @person.inventory.each do |item|
              if item.name.eql? "Wood log"
                @task = ActiveWalkAction.new(:end_location => @place,
                                             :thing => @person)
              end
            end
          elsif @task.is_a? ActiveWalkAction and @task.end_location.eql? @place
            @person.inventory.each do |item| 
              if item.name.eql? "Wood log"
                @person.inventory.delete item
                @place.inventory << item
              end
            end
            @task = nil
          elsif @task.is_a? SawWoodAction
            @task = nil
            @place.inventory << Item.new(:name => "Plank")
          end
        end
      else
        # Check for materials
        mats = false
        log = nil
        @place.inventory.each do |item|
          if item.name.eql? "Wood log"
            mats = true 
            log = item
          end
        end

        if mats
          @task = SawWoodAction.new
          @place.inventory.delete log
        else
          @task = ActiveWalkAction.new(:end_location => @foresters_hut,
                                       :thing => @person)
        end
      end
    end
  end
end

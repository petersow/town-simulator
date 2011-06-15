require 'town/clock'

module Town
  class Engine

    attr_accessor :seconds_to_run, :trees, :rivers
    attr_reader :people, :places, :job_roles, :clock

    FOREVER = -1

    def initialize(options = {})
      @messenger = options[:messenger] || STDOUT
      @clock = options[:clock] ||= Clock.new
      @seconds_to_run = options[:seconds_to_run] ||= FOREVER
      @options = options
   
      @places = init_places(options[:places_config])
      @job_roles = init_job_roles(options[:job_roles_config])
      @people = init_people(options[:people_config])

      @trees = init_trees(options[:trees_config])
      @rivers = init_rivers(options[:rivers_config])

      #add the extra elements to the proper job classes
      @people.each do |person|
        if person.job.is_a? Town::WoodCuttingJob
          person.job.person = person
          person.job.trees = @trees
        elsif person.job.is_a? Town::SawyerJob
          person.job.person = person
          @places.each do |place|
            if place.name.eql? "Foresters Hut"
              person.job.foresters_hut = place
            end
          end
        end
      end

      @action_generator = ActionGenerator.new
      @options[:sleep_time] = 0.05
      @options[:output_format] = options[:output_format] ||= "text"

    end 

    def tick
      # Update game clock
      @clock.tick
      @action_generator.time = @clock.time

      # Update people
      @people.each do |person|
        person.current_action = @action_generator.next_action(person)
      end
    end
 
    def start 
      @messenger.puts "Welcome to the Town!"

      @places.each do |place|
        @messenger.puts "#{place.name} is at (#{place.location.x}," +
                        "#{place.location.y},#{place.location.z})"
      end

      while not @seconds_to_run.eql?(0) do
        @clock.tick
        @action_generator.time = @clock.time
        if @options[:output_format].eql? "yaml"
          @messenger.puts @clock.to_yaml
        else
          @messenger.puts "#{@clock}\n"
        end

        @people.each do |person|
          person.current_action = @action_generator.next_action(person)
          @messenger.puts "#{person.first_name} #{person.family_name} is at " +
                          "(#{person.location.x},#{person.location.y}," +
                          "#{person.location.z})"
          @messenger.puts "#{person.first_name} #{person.family_name} is #{person.current_action}."
        end

	sleep @options[:sleep_time] ||= 1
        unless @seconds_to_run.eql?(FOREVER)
          @seconds_to_run -= 1
        end
      end
    end

    protected

    def init_people(people_config)
      result = []
      if people_config
        people_config.each_value do |person|
          new_person = Person.new
          person.each_pair do |key, value|
            #Date of birth isnt allowed to be set
            begin 
              if key.eql? "job"
                job_roles.each do |job_role|
                  if job_role.name.eql? value
                    value = job_role
                  end
                end
              end
              if key.eql? "home"
                places.each do |place|
                  if place.name.eql? value
                    value = place
                  end
                end
              end
              new_person.send "#{key}=", value
            rescue
            end
          end
          # Force start location to be the home
          begin
            new_person.location = new_person.home.location.clone
          rescue
          end
          result << new_person
        end
      end
      result
    end

    def init_places(places_config)
      result = []
      if places_config
        places_config.each_value do |place|
          new_place =  Place.new
          place.each_pair do |key, value|
            begin 
              if key.eql? "location"
                value = Location.new(:x => value["x"],
                                     :y => value["y"],
                                     :z => value["z"])

              end
              new_place.send "#{key}=", value
            rescue
            end
          end
          result << new_place
        end
      end
      result
    end

    def init_job_roles(job_roles_config)
      result = []
      if job_roles_config
        job_roles_config.each_value do |job_role|
          if job_role["name"].eql? "Forester"
            new_job_role = WoodCuttingJob.new
          elsif job_role["name"].eql? "Sawyer"
            new_job_role = SawyerJob.new
          else
            new_job_role = JobRole.new
          end
          job_role.each_pair do |key, value|
            begin 
              if key.eql? "place"
                places.each do |place|
                  if place.name.eql? value
                    value = place
                  end
                end
              end
              new_job_role.send "#{key}=", value
            rescue
            end
          end
          result << new_job_role
        end
      end
      result
    end

    def init_trees(trees)
      result = []
      trees.values.each do |tree|
        loc = tree["location"]
        loc = Town::Location.new(:x => loc["x"], :y => loc["y"], :z => loc["z"])
        result << Town::Tree.new(:location => loc)
      end
      return result
    end

    def init_rivers(rivers)
      result = []
      rivers.values.each do |river|
        blocks = []
        river.values.each do |block|
          loc = block["location"]
          loc = Town::Location.new(:x => loc["x"], :y => loc["y"], :z => loc["z"])
          river_block = Thing.new(:location => loc)
          blocks << river_block
        end
        river = River.new(:area => blocks)
        result << River.new(:area => blocks)
      end
      return result
    end
  end
end

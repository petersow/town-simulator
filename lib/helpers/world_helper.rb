
module Town
  class WorldHelper

    def self.find_nearest_tree(person, trees) 
      nearest = trees.first
      distance = person.location.distance(trees.first.location)

      trees.each do |tree|
        new_distance = person.location.distance(tree.location)
        if new_distance < distance
          distance = new_distance
          nearest = tree
        end
      end
      return nearest
    end

  end

end

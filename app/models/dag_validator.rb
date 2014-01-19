class DagValidator < ActiveModel::Validator

  require 'd_a_g'
  include DAG

  def validate(record)
    graph = DAG.new
    graph[record.parent_trait] = [record.child_trait]
    record.child_trait.game.game_traits.each do |trait|
      trait.game_trait_depencies.each do |dependency|
        if graph[dependency.parent_trait] = nil
          graph[dependency.parent_trait] = dependency.child_trait
        else
          graph[dependency.parent_trait] << dependency.child_trait
        end
      end
    end
    binding.pry
  end

  # def validate(record)
  #   parent = record.parent_trait
  #   child = record.child_trait
  #   child_visited = explore(child, [])
  #   binding.pry
  #   if child_visited.include?(parent)
  #     record.errors[:child] << 'This creates a prerequisites loop.'
  #   end
  # end

  # def explore(trait, visited)
  #   visited << trait
  #   trait.child_traits.each do |child|
  #     unless visited.include?(child)
  #       visited = explore(child, visited)
  #     end
  #   end
  #   visited
  # end

end

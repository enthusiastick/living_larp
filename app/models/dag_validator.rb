class DagValidator < ActiveModel::Validator

  def validate(record)
    parent = record.parent_trait
    child = record.child_trait
    child_visited = explore(child, [])
    binding.pry
    if child_visited.include?(parent)
      record.errors[:child] << 'This creates a prerequisites loop.'
    end
  end

  def explore(trait, visited)
    visited << trait
    trait.child_traits.each do |child|
      unless visited.include?(child)
        visited = explore(child, visited)
      end
    end
    visited
  end

end

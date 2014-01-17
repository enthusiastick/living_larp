class Prereq < ActiveModel::Validator
  def validate(record)
    character_game_traits = []
    record.character.traits.each do |trait|
      character_game_traits << trait.game_trait
    end
    prerequisites = record.game_trait.parent_traits
    prerequisites.each do |prereq|
      unless character_game_traits.include?(prereq)
        record.errors[:game_trait] << 'Prerequisites not met.'
      end
    end
  end

end


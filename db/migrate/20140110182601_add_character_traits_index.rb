class AddCharacterTraitsIndex < ActiveRecord::Migration
  def change
    add_index :traits, [ :game_trait_id, :character_id ],  { name: 'character_traits_index', unique: true }
  end
end

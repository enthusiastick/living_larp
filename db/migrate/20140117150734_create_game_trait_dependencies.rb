class CreateGameTraitDependencies < ActiveRecord::Migration
  def change
    create_table :game_trait_dependencies do |t|
      t.integer :parent_trait_id
      t.integer :child_trait_id

      t.timestamps
    end

    add_index :game_trait_dependencies, [ :parent_trait_id, :child_trait_id ], unique: true, name: 'prerequisite_game_trait_index'
  end
end

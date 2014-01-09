class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.integer :purchases, null: false
      t.integer :points_spent, null: false
      t.integer :game_trait_id, null: false
      t.integer :character_id, null: false

      t.timestamps
    end
  end
end

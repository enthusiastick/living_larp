class CreateGameTraits < ActiveRecord::Migration
  def change
    create_table :game_traits do |t|
      t.string :name
      t.integer :max_purchases
      t.boolean :bgs
      t.integer :point_cost
      t.integer :game_id

      t.timestamps
    end
  end
end

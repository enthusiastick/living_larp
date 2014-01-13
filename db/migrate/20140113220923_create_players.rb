class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id, null: false
      t.integer :game_id, null: false

      t.timestamps
    end

    add_index :players, [ :game_id, :user_id ], unique: true
  end
end

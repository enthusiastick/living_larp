class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.integer :available_points
      t.integer :user_id, null: false
      t.integer :game_id, null: false
    end
  end
end

class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.integer :starting_points, null: false

      t.timestamps
    end
  end
end

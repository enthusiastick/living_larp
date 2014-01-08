class ModifyGameTraits < ActiveRecord::Migration
  def up
    change_table :game_traits do |t|
      t.change :name, :string, null: false
      t.change :point_cost, :integer, null: false
      t.change :game_id, :integer, null: false
    end
  end

  def down
    change_table :game_traits do |t|
      t.change :name, :string, null: true
      t.change :point_cost, :integer, null: true
      t.change :game_id, :integer, null: true
    end
  end
end

class AddPointsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :points, :integer, default: 0
    Player.update_all(points: 0)
  end
end

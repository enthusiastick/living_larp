class AddPlayerIdToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :player_id, :integer
  end
end

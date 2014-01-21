class AddFroodToUsers < ActiveRecord::Migration
  def change
    add_column :users, :frood_on, :datetime
  end
end

class Character < ActiveRecord::Base
  validates_presence_of :name, :game_id, :user_id
  belongs_to :user
  belongs_to :game
end

class GameTrait < ActiveRecord::Base
  validates_presence_of :name, :point_cost, :game_id
  belongs_to :game
end

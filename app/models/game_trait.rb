class GameTrait < ActiveRecord::Base
  validates_presence_of :name, :point_cost, :game_id
  validates_numericality_of :point_cost, integer_only: true, greater_than: 0
  belongs_to :game
  has_many :traits
  has_many :characters, through: :traits
end

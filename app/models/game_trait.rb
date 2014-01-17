class GameTrait < ActiveRecord::Base
  validates_presence_of :name, :point_cost, :game_id
  validates_numericality_of :point_cost, integer_only: true, greater_than: 0
  belongs_to :game
  has_many :traits
  has_many :characters, through: :traits
  has_many :game_trait_dependencies, foreign_key: 'child_trait_id'
  has_many :parent_traits, through: :game_trait_dependencies
end

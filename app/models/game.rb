class Game < ActiveRecord::Base
  validates_presence_of :name, :starting_points
  validates_numericality_of :starting_points, integer_only: true, greater_than: 0
  validates_uniqueness_of :name
  belongs_to :user
  has_many :game_traits
  has_many :characters
  has_many :players
  has_many :users, through: :players
end

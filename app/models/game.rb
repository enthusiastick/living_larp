class Game < ActiveRecord::Base
  validates_presence_of :name, :starting_points
  validates_uniqueness_of :name
  belongs_to :user
  has_many :game_traits
  has_many :characters
end

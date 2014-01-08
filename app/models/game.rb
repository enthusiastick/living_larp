class Game < ActiveRecord::Base
  validates_presence_of :name, :starting_points
  belongs_to :user
  has_many :game_traits
end

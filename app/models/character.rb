class Character < ActiveRecord::Base
  validates_presence_of :name, :game_id, :user_id
  belongs_to :user
  belongs_to :game
  has_many :traits
  has_many :game_traits, through: :traits
end

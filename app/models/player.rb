class Player < ActiveRecord::Base
  validates_presence_of :game_id, :user_id
  validates_numericality_of :points, only_integer: true, greater_than_or_equal_to: 0

  validates_uniqueness_of :user, scope: :game

  belongs_to :user
  belongs_to :game
  has_many :characters

  def email
    self.user.email
  end

  def name
    self.game.name
  end

end

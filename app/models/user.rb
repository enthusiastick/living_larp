class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :games
  has_many :characters
  has_many :players
  has_many :games, through: :players

  def name
    self.email
  end

  def admin?
    self.frood_on != nil && self.frood_on < DateTime.now
  end

  def has_a_player_in?(game)
    games = []
    self.players.each do |player|
      games << player.game
    end
    games.include?(game)
  end

end

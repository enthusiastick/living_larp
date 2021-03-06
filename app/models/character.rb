class Character < ActiveRecord::Base
  validates_presence_of :name, :game_id, :user_id
  belongs_to :user
  belongs_to :game
  belongs_to :player
  has_many :traits
  has_many :game_traits, through: :traits

  before_create :starting_points

  def starting_points
    self.available_points = self.game.starting_points
  end

  def spent
    spent = 0
    self.traits.each do |trait|
      spent += trait.points_spent
    end
    spent
  end


end

class Trait < ActiveRecord::Base
  validates_presence_of :purchases, :game_trait_id, :character_id

  belongs_to :game_trait
  belongs_to :character

  before_save :set_cost
  before_validation :check_balance

  def set_cost
    self.points_spent = self.game_trait.point_cost * self.purchases
  end

  def check_balance
    unless self.game_trait == nil || self.purchases == nil
      character = self.character
      cost = self.game_trait.point_cost * self.purchases
      balance = character.available_points
      if balance - cost < 0
        false
      else
        character.decrement!(:available_points, by = cost)
        true
      end
    end
  end

end

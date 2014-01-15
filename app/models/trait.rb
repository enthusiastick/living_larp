class Trait < ActiveRecord::Base
  validates_presence_of :purchases, :game_trait_id, :character_id
  validates :game_trait_id, uniqueness: { scope: :character_id,
    message: "character trait already exists" }

  belongs_to :game_trait
  belongs_to :character

  before_create :set_cost
  validate :debit
  before_validation :allowed

  def set_cost
    self.points_spent = self.game_trait.point_cost * self.purchases
  end

  protected

  def allowed
    unless self.game_trait == nil || self.purchases == nil || self.game_trait.max_purchases == nil
      if self.purchases > self.game_trait.max_purchases
        errors.add(:purchases, "exceeds maximum purchases allowed")
        false
      else
        true
      end
    end
  end

  def debit
    unless self.game_trait == nil || self.purchases == nil
      if self.id == nil
        cost = self.game_trait.point_cost * self.purchases
      else
        cost = self.game_trait.point_cost * (self.purchases - (self.character.traits.find(self.id).purchases))
      end
      character = self.character
      balance = character.available_points
      if balance - cost < 0
        errors.add(:purchases, "not enough available points")
        false
      else
        character.decrement!(:available_points, by = cost)
        true
      end
    end
  end

end

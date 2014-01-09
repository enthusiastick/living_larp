class Trait < ActiveRecord::Base
  belongs_to :game_trait
  belongs_to :character

  before_save :set_cost

  def set_cost
    self.points_spent = self.game_trait.point_cost * self.purchases
  end

end

class Player < ActiveRecord::Base
  validates_presence_of :game_id, :user_id

  validates_uniqueness_of :user, scope: :game

  belongs_to :user
  belongs_to :game

  def email
    self.user.email
  end

end

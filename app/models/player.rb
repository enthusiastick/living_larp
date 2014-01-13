class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def email
    self.user.email
  end

end

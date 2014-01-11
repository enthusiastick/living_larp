class PrerequisiteTrait < ActiveRecord::Base
  has_many :game_traits, foreign_key: :parent_id
  belongs_to :game_trait, foreign_key: :child_id
end

class GameTraitDependency < ActiveRecord::Base
  belongs_to :parent_trait, class_name: 'GameTrait'
  belongs_to :child_trait, class_name: 'GameTrait'
end

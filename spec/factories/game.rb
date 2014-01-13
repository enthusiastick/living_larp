FactoryGirl.define do
  factory :game do
    sequence(:name) {|n| "Knight Blades #{n}" }
    starting_points "25"
    user
  end
end

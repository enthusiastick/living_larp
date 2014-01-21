require 'spec_helper'

feature "User configures a prerequisite trait", %Q{
  As an authenticated user
  I want to add prerequisite traits to a game
  So that my system can have complexity
} do

  # Acceptance Criteria:
  # * I must specify the parent trait and child trait for the dependency.
  # * If I do not specify required info, I am presented with an error
  # * If I specify required info, the prerequisite is saved

  scenario "happy path" do
    count = GameTraitDependency.count
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user)
    game_trait1 = FactoryGirl.create(:game_trait, game: game)
    game_trait2 = FactoryGirl.create(:game_trait, game: game, name: "Slay")
    login(user)
    visit game_path(game)
    click_on "Set Prerequisite"
    select(game_trait2.name, from: "Child")
    select(game_trait1.name, from: "Parent")
    click_button "Set"

    expect(page).to have_content("successfully")
    expect(GameTraitDependency.count).to eq(count + 1)
    expect(GameTraitDependency.last.parent_trait).to eq(game_trait1)
    expect(GameTraitDependency.last.child_trait).to eq(game_trait2)
  end

  # scenario "happy path" do
  #   count = GameTrait.count
  #   user = FactoryGirl.create(:user)
  #   game = FactoryGirl.create(:game, user: user)
  #   login(user)
  #   visit new_game_game_trait_path(game)
  #   fill_in "Name", with: "Repose of Peace"
  #   fill_in "Point", with: "3"
  #   uncheck("Downtime")
  #   click_on "Add Trait"

  #   expect(page).to have_content("Repose of Peace")
  #   expect(GameTrait.count).to eq(count + 1)
  #   expect(GameTrait.last.game_id).to eq(game.id)
  # end

  # scenario "no specified info" do
  #   count = GameTrait.count
  #   user = FactoryGirl.create(:user)
  #   game = FactoryGirl.create(:game, user: user)
  #   login(user)
  #   visit new_game_game_trait_path(game)
  #   click_on "Add Trait"

  #   expect(page).to have_content("Error")
  #   expect(GameTrait.count).to eq(count)
  # end

end

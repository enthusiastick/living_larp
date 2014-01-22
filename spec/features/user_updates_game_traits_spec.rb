require 'spec_helper'

feature "User configures a game", %Q{
  As an authenticated user
  I want to update traits for a game
  So that they reflect changes to the rules over time
} do

  # Acceptance Criteria:
  # * I must specify the trait's name, bgs(boolean) and point cost.
  # * I may optionally specify max purchases.
  # * If I do not specify required info, I am presented with an error
  # * If I specify required info, the trait is saved

  scenario "happy path" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user)
    game_trait = FactoryGirl.create(:game_trait, game: game)
    count = GameTrait.count
    login(user)
    visit game_game_trait_path(game, game_trait)
    fill_in "Name", with: "Repose of Peace"
    fill_in "Point", with: "3"
    uncheck("Downtime")
    click_on "Update Trait"

    expect(page).to have_content("Repose of Peace")
    expect(page).to have_content("updated")
    expect(GameTrait.count).to eq(count)
    expect(GameTrait.last).to eq(game_trait)
  end

  scenario "invalid input" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user)
    game_trait = FactoryGirl.create(:game_trait, game: game)
    login(user)
    visit game_game_trait_path(game, game_trait)
    fill_in "Name", with: ""
    fill_in "Point", with: ""
    click_on "Update Trait"

    expect(page).to have_content("Error")
  end

end

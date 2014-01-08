require 'spec_helper'

feature "User creates a game", %Q{
  As an authenticated user
  I want to add traits to a game
  So that users can create characters
} do

  # Acceptance Criteria:
  # * I must specify the trait's name, bgs(boolean) and point cost.
  # * I may optionally specify max purchases.
  # * If I do not specify required info, I am presented with an error
  # * If I specify required info, the trait is saved

  scenario "happy path" do
    count = GameTrait.all.count
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user)
    login(user)
    visit game_path(game)
    fill_in "Name", with: "Repose of Peace"
    fill_in "Point", with: "3"
    uncheck("BGS?")
    click_on "Add Trait"

    expect(page).to have_content("Repose of Peace")
    expect(GameTrait.all.count).to eq(count + 1)
    expect(GameTrait.last.game_id).to eq(game.id)
  end

end

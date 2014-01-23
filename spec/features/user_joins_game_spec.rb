require 'spec_helper'

feature "User adds players to a game", %Q{
  As an authenticated user
  I want to become a player in a game
  so that I can create a character
} do

  # Acceptance Criteria:
  # * I must be logged in and join a valid game.
  # * If I am not logged in or do not specify a valid game, an error is displayed.
  # * If I specify required info, my player connection is saved and I can create characters

  scenario "happy path" do
    count = Player.count
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    login(user)
    visit game_path(game)
    click_on "Join Game"
    click_on "Confirm"

    expect(page).to have_content("success")
    expect(Player.count).to eq(count + 1)
    expect(Player.last.user).to eq(user)
    expect(Player.last.game).to eq(game)
  end

  scenario "already joined game" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    player = FactoryGirl.create(:player, user: user, game: game)
    login(user)
    visit game_path(game)

    expect(page).to_not have_button("Join Game")
  end

end

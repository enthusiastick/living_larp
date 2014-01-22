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

  # scenario "happy path" do
  #   count = Player.count
  #   user1 = FactoryGirl.create(:user)
  #   user2 = FactoryGirl.create(:user)
  #   game = FactoryGirl.create(:game, user: user1)
  #   login(user1)
  #   visit game_players_path(game)
  #   fill_in "Email", with: user2.email
  #   click_on "Add Player"
  #   click_on "Confirm"

  #   expect(page).to have_content("success")
  #   expect(Player.count).to eq(count + 1)
  #   expect(Player.last.user).to eq(user2)
  #   expect(Player.last.game).to eq(game)
  # end

  # scenario "invalid user" do
  #   count = Player.count
  #   user = FactoryGirl.create(:user)
  #   game = FactoryGirl.create(:game, user: user)
  #   login(user)
  #   visit game_players_path(game)
  #   fill_in "Email", with: "puffthemagicdragon@example.com"
  #   click_on "Add Player"

  #   expect(page).to have_content("not found")
  #   expect(Player.count).to eq(count)
  # end

  # scenario "view players index" do
  #   user = FactoryGirl.create(:user)
  #   game = FactoryGirl.create(:game, user: user)
  #   player1 = FactoryGirl.create(:player, game: game)
  #   player2 = FactoryGirl.create(:player, game: game)
  #   login(user)
  #   visit game_players_path(game)

  #   expect(page).to have_content(player1.user.name)
  #   expect(page).to have_content(player2.user.name)
  # end

end

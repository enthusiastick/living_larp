require 'spec_helper'

feature "User configures a game", %Q{
  As an authenticated user with a valid game
  I want to invite other users to play the game
  so that they can create characters
} do

  # Acceptance Criteria:
  # * I must specify the user's correct email address.
  # * If I do not specify a valid user, I am presented with an error.
  # * If I do specify a valid user, they are added as a player of my game.
  # * I can view a list of current players in my game.

  scenario "happy path" do
    count = Player.count
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user1)
    login(user1)
    visit game_path(game)
    click_on "Add Player"
    fill_in "Email", with: user2.email
    click_on "Add Player"

    expect(page).to have_content("success")
    expect(Player.count).to eq(count + 1)
    expect(Player.last.user).to eq(user2)
    expect(Player.last.game).to eq(game)
  end

end

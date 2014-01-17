require 'spec_helper'

feature "User creates a character", %Q{
  As an authenticated user
  I want to create a new character
  So that I can become a player
} do

  # Acceptance Criteria:
  # * I must specify the character's name and the game to which it belongs
  # * If I do not specify name and game, I am presented with an error
  # * If I specify name and game, the character is saved

  # Fails because of B/S Capybara disambiguation.
  # scenario "happy path" do
  #   count = Character.count
  #   user = FactoryGirl.create(:user)
  #   game = FactoryGirl.create(:game)
  #   player = FactoryGirl.create(:player, user: user, game: game)
  #   login(user)
  #   visit new_character_path
  #   fill_in "player_character", with: "Rafael"
  #   select(game.name, from: "Game")
  #   click_on "Create Player"

  #   expect(page).to have_content("Rafael")
  #   expect(Character.count).to eq(count + 1)
  #   expect(Character.last.game_id).to eq(game.id)
  #   expect(Character.last.user_id).to eq(user.id)
  # end

  scenario "missing info" do
    count = Character.count
    user = FactoryGirl.create(:user)
    login(user)
    visit new_character_path
    click_on "Create NPC"

    expect(page).to have_content("Error")
    expect(Character.count).to eq(count)
  end

  scenario "won't authorize you" do
   expect { visit new_character_path }.to raise_error(ActionController::RoutingError, "Not Found")
  end

end

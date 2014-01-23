require 'spec_helper'

feature "User views a game", %Q{
  As an authenticated user
  I want to view a game I've created
  So that I can configure its traits
} do

  # Acceptance Criteria:
  # * The game's name and starting points must be displayed
  # * If I am not logged in, I cannot view the game
  # * If I am logged in, I cannot edit a game belonging to another user

  scenario "not logged in" do
    game = FactoryGirl.create(:game)
    visit game_path(game)

    expect(page).to have_button('Sign Up')
    expect(page).to have_button('Sign In')
  end

  scenario "logged in, not my game" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    login(user)
    visit game_path(game)

    expect(page).to_not have_button('Update')
    expect(page).to_not have_button('Configure')
    expect(page).to_not have_button('Set')
    expect(page).to_not have_button('Manage')
  end

  scenario "logged in, my game" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user)
    login(user)
    visit game_path(game)

    expect(page).to have_content(game.name)
  end

end

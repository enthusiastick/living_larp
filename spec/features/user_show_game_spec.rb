require 'spec_helper'

feature "User views a game", %Q{
  As an authenticated user
  I want to view a game I've created
  So that I can configure its traits
} do

  # Acceptance Criteria:
  # * The game's name and starting points must be displayed
  # * If I am not logged in, I cannot view the game
  # * If I am logged in, I cannot view a game belonging to another user

  scenario "not logged in" do
    game = FactoryGirl.create(:game)

    expect { visit game_path(game) }.to raise_error(ActionController::RoutingError, "Not Found")
  end

  scenario "logged in, not my game" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    login(user)

    expect { visit game_path(game) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  scenario "logged in, my game" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user)
    login(user)
    visit game_path(game)

    expect(page).to have_content(game.name)
  end

end

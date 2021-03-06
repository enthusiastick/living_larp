require 'spec_helper'

feature "User views games index", %Q{
  As an authenticated user
  I want to see the games I've created
  So that I can know what I'm working with
} do

  # Acceptance Criteria:
  # * If I have added no games, no games should be displayed
  # * Games that I have added should be displayed
  # * Games added by other users should not be displayed

  scenario "with no games" do
    user = FactoryGirl.create(:user)
    login(user)
    visit games_path

    expect(page).to have_button("Create A Game")
  end

  scenario "with games only created by user" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user)
    login(user)
    visit games_path

    expect(page).to have_content(game.name)
  end

  scenario "with games created by many users" do
    user = FactoryGirl.create(:user)
    game1 = FactoryGirl.create(:game, user: user, name: 'Dystopia Rising')
    game2 = FactoryGirl.create(:game)
    login(user)
    visit games_path

    expect(page).to have_content(game1.name)
    expect(page).to_not have_content(game2.name)
  end

end

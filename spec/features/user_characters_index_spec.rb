require 'spec_helper'

feature "User views characters index", %Q{
  As an authenticated user
  I want to see the characters I've created
  So that I can choose one to update
} do

  # Acceptance Criteria:
  # * If I have added no characters, no characters should be displayed
  # * Characters that I have added should be displayed
  # * Characters added by other users should not be displayed

  scenario "with no characters" do
    user = FactoryGirl.create(:user)
    login(user)
    visit characters_path

    expect(page).to have_content("Add New Character")
  end

  scenario "with characters only created by user" do
    user = FactoryGirl.create(:user)
    character = FactoryGirl.create(:character, user: user)
    login(user)
    visit characters_path

    expect(page).to have_content(character.name)
  end

  # scenario "with games created by many users" do
  #   user = FactoryGirl.create(:user)
  #   game1 = FactoryGirl.create(:game, user: user, name: 'Dystopia Rising')
  #   game2 = FactoryGirl.create(:game)
  #   login(user)
  #   visit games_path

  #   expect(page).to have_content(game1.name)
  #   expect(page).to_not have_content(game2.name)
  # end

end

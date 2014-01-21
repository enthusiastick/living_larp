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

    expect(page).to have_button("Create A Character")
  end

  scenario "with characters only created by user" do
    user = FactoryGirl.create(:user)
    character = FactoryGirl.create(:character, user: user)
    login(user)
    visit characters_path

    expect(page).to have_content(character.name)
  end

  scenario "with characters created by many users" do
    user = FactoryGirl.create(:user)
    character1 = FactoryGirl.create(:character, user: user, name: 'George Michael')
    character2 = FactoryGirl.create(:character)
    login(user)
    visit characters_path

    expect(page).to have_content(character1.name)
    expect(page).to_not have_content(character2.name)
  end

end

require 'spec_helper'

feature "User creates a game", %Q{
  As an authenticated user
  I want to create a game
  So that I can begin configuring it
} do

  # Acceptance Criteria:
  # * I must specify the game's name and starting character points
  # * If I do not specify name and points, I am presented with an error
  # * If I specify name and point, the game is saved

  context "with valid input" do
    it "records a game" do
      count = Game.count
      user = FactoryGirl.create(:user)
      login(user)
      visit new_game_path
      fill_in "Name", with: "Witchwood"
      fill_in "Starting", with: "25"
      click_on "Create Game"

      expect(page).to have_content("Witchwood")
      expect(Game.count).to eq(count + 1)
      expect(Game.last.user_id).to eq(user.id)
    end

  end

  context "with invalid input" do
    it "throws an error" do
      count = Game.count
      user = FactoryGirl.create(:user)
      login(user)
      visit new_game_path
      click_on "Create Game"

      expect(page).to have_content("Error")
      expect(Game.count).to eq(count)
    end

  end

  context "not logged in" do
    it "won't authorize you" do
      expect { visit new_game_path }.to raise_error(ActionController::RoutingError, "Not Found")
    end

  end

end

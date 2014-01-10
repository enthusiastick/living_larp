require 'spec_helper'

feature "User adds traits to a character", %Q{
  As an authenticated user
  I want to configure traits for my character
  So that I can play the game
} do

  # Acceptance Criteria:
  # * I must specify the traits I wish to purchase, and how many times
  # * If I have specified correctly and have enough available points, my purchase is saved
  # * If I have not specified or do not have enough available points, I am presented with an error

  scenario "happy path" do
    count = Trait.all.count
    user = FactoryGirl.create(:user)
    login(user)
    make(@game, @game_trait, @character)

    expect(page).to have_content("successfully")
    expect(page).to have_content("97")
    expect(Trait.all.count).to eq(count + 1)
    expect(Trait.last.game_trait_id).to eq(@game_trait.id)
    expect(Trait.last.character_id).to eq(@character.id)
  end

  scenario "no specified info" do
    count = Trait.all.count
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, name: "Beta")
    game_trait = FactoryGirl.create(:game_trait, game: game)
    character = FactoryGirl.create(:character)
    login(user)
    visit character_path(character)
    click_on "Update Character"

    expect(page).to have_content("check your input")
    expect(Trait.all.count).to eq(count)
  end

  scenario "not enough available points" do
    count = Trait.all.count
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, name: "Charlie")
    game_trait = FactoryGirl.create(:game_trait, game: game)
    character = FactoryGirl.create(:character)
    login(user)
    visit character_path(character)
    select(game_trait.name, from: "trait")
    fill_in "Purchases", with: "1000"
    click_on "Update Character"

    expect(page).to have_content("do not have enough")
    expect(Trait.all.count).to eq(count)
  end

end

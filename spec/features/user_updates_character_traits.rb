require 'spec_helper'

feature "User updates character traits", %Q{
  As an authenticated user
  I want to update traits for my character
  So that I can play the game
} do

  # Acceptance Criteria:
  # * I must specify a trait I have already purchased, and how many additional purchases I wish to make
  # * If I have specified correctly and have enough available points, my purchase is saved
  # * If I have not specified or do not have enough available points, I am presented with an error

  scenario "happy path" do
    count = Trait.count
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    game_trait = FactoryGirl.create(:game_trait, game: game)
    player = FactoryGirl.create(:player, user: user, game: game)
    character = FactoryGirl.create(:character, user: user, player: player, game: game)
    login(user)
    3.times do
      visit character_path(character)
      click_on "Update Character"
      select(game_trait.name, from: "trait")
      fill_in "Purchases", with: "1"
      click_on "Update Character"
    end

    expect(page).to have_content("successfully")
    expect(page).to have_content(game_trait.name + ' 3')
    expect(page).to have_content(game.starting_points - (game_trait.point_cost*3))
    expect(Trait.count).to eq(count + 1)
    expect(Trait.last.purchases).to eq(3)
  end

  scenario "not enough available points" do
    count = Trait.count
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    game_trait = FactoryGirl.create(:game_trait, game: game)
    player = FactoryGirl.create(:player, user: user, game: game)
    character = FactoryGirl.create(:character, user: user, player: player, game: game)
    login(user)
    2.times do
      visit character_path(character)
      click_on "Update Character"
      select(game_trait.name, from: "trait")
      fill_in "Purchases", with: "5"
      click_on "Update Character"
    end

    expect(page).to have_content("not enough")
    expect(page).to have_content(game_trait.name + ' 5')
    expect(page).to have_content(game.starting_points - (game_trait.point_cost*5))
    expect(Trait.count).to eq(count + 1)
    expect(Trait.last.purchases).to eq(5)
  end

  scenario "exceeds max purchases" do
    count = Trait.count
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    game_trait = FactoryGirl.create(:game_trait, game: game)
    player = FactoryGirl.create(:player, user: user, game: game)
    character = FactoryGirl.create(:character, user: user, player: player, game: game)
    login(user)
    visit character_path(character)
    click_on "Update Character"
    select(game_trait.name, from: "trait")
    fill_in "Purchases", with: "1"
    click_on "Update Character"
    visit character_path(character)
    click_on "Update Character"
    select(game_trait.name, from: "trait")
    fill_in "Purchases", with: "1000"
    click_on "Update Character"

    expect(page).to have_content("exceeds maximum purchases")
    expect(page).to have_content(game_trait.name + ' 1')
    expect(page).to have_content(game.starting_points - game_trait.point_cost)
    expect(Trait.count).to eq(count + 1)
    expect(Trait.last.purchases).to eq(1)
  end

end

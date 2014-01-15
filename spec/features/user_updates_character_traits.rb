require 'spec_helper'

feature "User adds traits to a character", %Q{
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
    2.times do
      visit character_path(character)
      click_on "Update Character"
      select(game_trait.name, from: "trait")
      fill_in "Purchases", with: "1"
      click_on "Update Character"
    end

    expect(page).to have_content("successfully")
    expect(page).to have_content(game_trait.name + ' 2')
    expect(page).to have_content(game.starting_points - (game_trait.point_cost*2))
    expect(Trait.count).to eq(count)
    expect(Trait.last.purchases).to eq(2)
  end


  # scenario "happy path" do
  #   count = Trait.count
  #   user = FactoryGirl.create(:user)
  #   game = FactoryGirl.create(:game, user: user)
  #   game_trait = FactoryGirl.create(:game_trait, game: game)
  #   character = FactoryGirl.create(:character, game: game, user: user)
  #   login(user)
  #   visit character_path(character)
  #   click_on "Update Character"
  #   select(game_trait.name, from: "trait")
  #   fill_in "Purchases", with: "1"
  #   click_on "Update Character"

  #   expect(page).to have_content("successfully")
  #   expect(page).to have_content(game.starting_points - game_trait.point_cost)
  #   expect(Trait.count).to eq(count + 1)
  #   expect(Trait.last.game_trait_id).to eq(game_trait.id)
  #   expect(Trait.last.character_id).to eq(character.id)
  # end

  # scenario "no specified info" do
  #   count = Trait.count
  #   user = FactoryGirl.create(:user)
  #   game = FactoryGirl.create(:game, user: user)
  #   game_trait = FactoryGirl.create(:game_trait, game: game)
  #   character = FactoryGirl.create(:character, game: game, user: user)
  #   login(user)
  #   visit character_path(character)
  #   2.times do
  #     click_on "Update Character"
  #   end
  #   expect(page).to have_content("check your input")
  #   expect(Trait.count).to eq(count)
  # end

  # scenario "not enough available points" do
  #   count = Trait.count
  #   user = FactoryGirl.create(:user)
  #   game = FactoryGirl.create(:game, user: user)
  #   game_trait = FactoryGirl.create(:game_trait, game: game)
  #   character = FactoryGirl.create(:character, game: game, user: user)
  #   login(user)
  #   visit character_path(character)
  #   click_on "Update Character"
  #   select(game_trait.name, from: "trait")
  #   fill_in "Purchases", with: "10"
  #   click_on "Update Character"

  #   expect(page).to have_content("not enough")
  #   expect(Trait.count).to eq(count)
  # end

  # scenario "exceeds max purchases" do
  #   count = Trait.count
  #   user = FactoryGirl.create(:user)
  #   game = FactoryGirl.create(:game, user: user)
  #   game_trait = FactoryGirl.create(:game_trait, game: game)
  #   character = FactoryGirl.create(:character, game: game, user: user)
  #   login(user)
  #   visit character_path(character)
  #   click_on "Update Character"
  #   select(game_trait.name, from: "trait")
  #   fill_in "Purchases", with: "1000"
  #   click_on "Update Character"

  #   expect(page).to have_content("exceeds maximum purchases")
  #   expect(Trait.count).to eq(count)
  # end

end

module TraitHelper
  def make(game, game_trait, character)
    visit new_game_path
    fill_in 'Name', with: game.to_s
    fill_in 'points', with: '100'
    click_on 'Create Game'
    visit game_path(game)
    fill_in 'Trait', with: game_trait.to_s
    fill_in 'cost', with: '3'
    click_on 'Add Trait'
    visit new_character_path
    fill_in 'Name', with: character.to_s
    select(game.to_s, from: 'Game')
    click_on 'Create Character'
    visit character_path(character)
    select(game_trait.to_s, from: 'trait')
    fill_in 'Purchases', with: '1'
    click_on 'Update Character'
  end
end

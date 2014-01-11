class TraitsController < ApplicationController

  before_action :authenticate_user, only: :create

  def create
    @character = Character.find(params[:character_id])
    @trait = Trait.new(trait_params)
    @trait.character = @character
    if @trait.save
      flash['alert-box success'] = "Character updated successfully."
      redirect_to new_character_trait_path(@character)
    else
      flash.now['alert-box alert'] = "Error! Please check your input and retry."
      render 'traits/new'
    end
  end

  def new
    @character = Character.find(params[:character_id])
    @trait = Trait.new
    @traits_collection = @character.game.game_traits
  end

  protected

  def trait_params
    params.require(:trait).permit(:purchases, :game_trait_id, :character_id)
  end

end

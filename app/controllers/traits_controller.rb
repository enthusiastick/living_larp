class TraitsController < ApplicationController

  before_action :authenticate_user, only: :create

  def create
    @character = Character.find(params[:character_id])
    @trait = Trait.new(trait_params)
    @trait.character = @character
    if @trait.save
      flash['alert-box success'] = "Character updated successfully."
      redirect_to character_path(@character)
    else
      if @trait.purchases == nil || @trait.game_trait_id == nil
        flash.now['alert-box alert'] = "Error! Please check your input and retry."
      else
        flash.now['alert-box alert'] = "Error! You do not have enough available points to add this trait."
      end
      render 'characters/show'
    end
  end

  protected

  def trait_params
    params.require(:trait).permit(:purchases, :game_trait_id, :character_id)
  end

end

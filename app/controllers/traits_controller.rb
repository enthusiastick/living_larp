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
      flash.now['alert-box alert'] = "Error! Please check your input and retry."
    end
    render 'characters/show'
  end

  protected

  def trait_params
    params.require(:trait).permit(:purchases, :game_trait_id, :character_id)
  end

end

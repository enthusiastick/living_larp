class GameTraitsController < ApplicationController

  def create
    @game = Game.find(params[:game_id])
    @game_trait = GameTrait.new(game_trait_params)
    @game_trait.game = @game
    if @game_trait.save
      flash[:notice] = "Trait added successfully."
    else
      flash[:error] = "Error! Please check your input and retry."
    end
    redirect_to game_path(@game)
  end

  def new
    @game_trait = GameTrait.new
  end

  protected

  def game_trait_params
    params.require(:game_trait).permit(:name, :max_purchases, :bgs, :point_cost, :game_id)
  end

end

class GameTraitsController < ApplicationController

  before_action :authenticate_user, only: [:new, :create]

  def create
    @game = Game.find(params[:game_id])
    @game_trait = GameTrait.new(game_trait_params)
    @game_trait.game = @game
    if @game_trait.save
      flash[:success] = "Trait added successfully."
      redirect_to new_game_game_trait_path(@game)
    else
      flash.now[:alert] = "Error! Please check your input and retry."
      render 'game_traits/new'
    end

  end

  def new
    @game = Game.find(params[:game_id])
    @game_trait = GameTrait.new
  end

  protected

  def game_trait_params
    params.require(:game_trait).permit(:name, :max_purchases, :bgs, :point_cost, :game_id, :game_trait_id)
  end

end

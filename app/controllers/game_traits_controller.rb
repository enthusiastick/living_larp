class GameTraitsController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :show]

  def create
    @game = Game.find(params[:game_id])
    @game_trait = GameTrait.new(game_trait_params)
    @game_traits = @game.game_traits.order(:name)
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
    @game_traits = @game.game_traits.order(:name)
  end

  def show
    @game_trait = GameTrait.find(params[:id])
    @game = @game_trait.game
  end

  def update
    @game_trait = GameTrait.find(params[:id])
    @game = @game_trait.game
    if @game_trait.update(game_trait_params)
      flash[:success] = "\'#{@game_trait.name}\' updated successfully."
      redirect_to new_game_game_trait_path(@game)
    else
      flash.now[:alert] = "Error! Unable to update trait."
      render 'show'
    end
  end

  protected

  def game_trait_params
    params.require(:game_trait).permit(:name, :max_purchases, :bgs, :point_cost, :game)
  end

end

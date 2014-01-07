class GamesController < ApplicationController

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:notice] = "Game created successfully."
      redirect_to game_path(@game)
    else
      flash[:error] = "Error! Please check your input and retry."
      render :new
    end
  end

  def new
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:name, :starting_points)
  end

end

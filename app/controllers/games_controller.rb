class GamesController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :update, :player_characters]

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    if @game.save
      flash[:success] = "Game created successfully."
      redirect_to game_path(@game)
    else
      flash.now[:alert] = "Error! Please check your input and retry."
      render :new
    end
  end

  def index
    @games = Game.all.select { |g| g.user == current_user }
  end

  def new
    @game = Game.new
  end

  def player_characters
    @game = Game.find(params[:game_id])
    @characters = @game.characters.order(:name)
  end

  def show
    @game = Game.find(params[:id])
    @game_traits = @game.game_traits.order(:name)
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(desc_params)
      flash[:success] = "Game description updated successfully."
      redirect_to game_path(@game)
    else
      flash.now[:alert] = "Error! Unable to update game description."
      render 'show'
    end
  end

  protected

  def desc_params
    params.require(:game).permit(:description)
  end

  def game_params
    params.require(:game).permit(:name, :starting_points)
  end

end

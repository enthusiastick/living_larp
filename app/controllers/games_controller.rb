class GamesController < ApplicationController

  before_action :authenticate_user, only: [:new, :create]
  before_action :set_user, only: [:create, :index, :show]

  def create
    @game = Game.new(game_params)
    @game.user = @user
    if @game.save
      flash['alert-box success'] = "Game created successfully."
      redirect_to game_path(@game)
    else
      flash.now['alert-box alert'] = "Error! Please check your input and retry."
      render :new
    end
  end

  def index
  end

  def new
    @game = Game.new
  end

  def show
    if @user == nil
      raise ActionController::RoutingError.new('Not Found')
    else
      @game = @user.games.find(params[:id])
    end
  end

  protected

  def game_params
    params.require(:game).permit(:name, :starting_points)
  end

end

class PlayersController < ApplicationController

  def create
    @player = Player.new(player_params)
    @player.points = 0
    if @player.save
      flash[:success] = "Player added successfully."
    else
      flash[:alert] = "Error! Unable to add player."
    end
    redirect_to game_players_path(@player.game)
  end

  def index
    @game = Game.find(params[:game_id])
    @players = @game.players
  end

  def new
    @game = Game.find(params[:game_id])
    user_search = User.find_by email:(params[:email])
    if user_search == nil
      flash[:alert] = "User not found."
      redirect_to game_players_path(@game)
    else
      @player = Player.new
      @user = user_search
    end
  end

  def show
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    @player.points = @player.points + points_param.to_i
    if @player.save
      flash.now[:success] = "Points awarded successfully."
      render 'show'
    else
      flash[:alert] = "Error! Unable to award points."
      redirect_to game_player_path(@player.game, @player)
    end
  end

  protected

  def player_params
    params.require(:player).permit(:user_id, :game_id)
  end

  def points_param
    params.require(:points)
  end

end

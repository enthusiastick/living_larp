class PlayersController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :show]

  def create
    @player = Player.new(player_params)
    @player.points = 0
    if params[:player][:user_id] == current_user.id.to_s
      if @player.save
        flash[:success] = "Game joined successfully."
      else
        flash[:alert] = "Error! unable to join game."
      end
      redirect_to new_character_path
    else
      if @player.save
        flash[:success] = "Player added successfully."
      else
        flash[:alert] = "Error! Unable to add player."
      end
      redirect_to game_players_path(@player.game)
    end
  end

  def index
    @game = Game.find(params[:game_id])
    @players = @game.players
  end

  def new
    @game = Game.find(params[:game_id])
    if params[:email] == nil
      @player = Player.new
      @user = current_user
    else
      user_search = User.find_by email:(params[:email])
      if user_search == nil
        flash[:alert] = "User not found."
        redirect_to game_players_path(@game)
      else
        @player = Player.new
        @user = user_search
      end
    end
  end

  def show
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if points_param.to_i <= 0
      flash[:alert] = "Error! Unable to award points."
      redirect_to game_player_path(@player.game, @player)
    else
      @player.points = @player.points + points_param.to_i
      if @player.save
        flash.now[:success] = "Points awarded successfully."
        render 'show'
      else
        flash[:alert] = "Error! Unable to award points."
        redirect_to game_player_path(@player.game, @player)
      end
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

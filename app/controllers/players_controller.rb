class PlayersController < ApplicationController

  def create
    @player = Player.new(player_params)
    if @player.save
      flash['alert-box success'] = "Player added successfully."
    else
      flash['alert-box alert'] = "Error! Unable to add player."
    end
    redirect_to game_players_path(@player.game)
  end

  def index
    @game = Game.find(params[:game_id])
    @playerlist = Array.new
    @game.players.each do |player|
      @playerlist << player.user
    end
  end

  def new
    @game = Game.find(params[:game_id])
    user_search = User.find_by email:(params[:email])
    if user_search == nil
      flash['alert-box alert'] = "User not found."
      redirect_to game_players_path(@game)
    else
      @player = Player.new
      @user = user_search
    end
  end

  protected

  def player_params
    params.require(:player).permit(:user_id, :game_id)
  end

end

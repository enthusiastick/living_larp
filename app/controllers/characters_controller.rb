class CharactersController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :show]

  def create
    @character = Character.new(character_params)
    @games = Game.all.select { |g| g.user == current_user }
    @player_games = Player.all.select { |p| p.user == current_user }
    @character.user = current_user
    @character.game = @character.player.game unless @character.player == nil
      if @character.save
        flash[:success] = "Character created successfully."
        redirect_to character_path(@character)
      else
        flash.now[:alert] = "Error! Please check your input and retry."
        render :new
      end
  end

  def new
    @character = Character.new
    @games = Game.all.select { |g| g.user == current_user }
    @player_games = Player.all.select { |p| p.user == current_user }
  end

  def show
    if Character.find(params[:id]).game.user == current_user
      @character = Character.find(params[:id])
    elsif user_signed_in?
      @character = current_user.characters.find(params[:id]) if current_user.characters.find(params[:id]) != nil
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def update
    @character = Character.find(params[:id])
    @player = @character.player
    if @player.points < point_params.to_i || point_params.to_i <= 0
      flash[:alert] = "Error! Transaction could not be completed."
      redirect_to character_path(@character)
    else
      @character.available_points = @character.available_points + point_params.to_i
      if @character.save
        @player.decrement!(:points, by = point_params.to_i)
        flash.now[:success] = "Points transferred successfully."
        render 'show'
      else
        flash[:alert] = "Error! Unable to transfer points."
        redirect_to character_path(@character)
      end
    end
  end

  protected

  def character_params
    params.require(:character).permit(:name, :game_id, :user_id, :available_points, :player_id)
  end

  def point_params
    params.require(:available_points)
  end

end

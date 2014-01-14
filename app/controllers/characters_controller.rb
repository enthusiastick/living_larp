class CharactersController < ApplicationController

  before_action :authenticate_user, only: [:new, :create]
  # before_action :set_user, only: [:create, :index, :show]

  def create
    @character = Character.new(character_params)
    @character.user = current_user
      if @character.save
        flash['alert-box success'] = "Character created successfully."
        redirect_to character_path(@character)
      else
        flash.now['alert-box alert'] = "Error! Please check your input and retry."
        render :new
      end
  end

  def index

  end

  def new
    @character = Character.new
    @games_list = current_user.games
    unless current_user.players == nil
      current_user.players.each do |player|
        @games_list << player.game
      end
    end
  end

  def show
    if user_signed_in?
      @character = current_user.characters.find(params[:id])
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  protected

  def character_params
    params.require(:character).permit(:name, :game_id, :user_id, :available_points)
  end

end

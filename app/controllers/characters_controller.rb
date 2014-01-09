class CharactersController < ApplicationController

  before_action :authenticate_user, only: [:new, :create]

  def create
    set_user
    @character = Character.new(character_params)
    @character.user = @user
      if @character.save
        flash['alert-box success'] = "Character created successfully."
        redirect_to character_path(@character)
      else
        flash.now['alert-box alert'] = "Error! Please check your input and retry."
        render :new
      end
  end

  def new
    @character = Character.new
  end

  def show
    @character = Character.find(params[:id])
  end

  protected

  def character_params
    params.require(:character).permit(:name, :game_id, :user_id)
  end

end

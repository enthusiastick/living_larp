class TraitsController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :show]

  def create
    @character = Character.find(params[:character_id])
    @trait = Trait.find_or_initialize_by(character: @character, game_trait_id: params[:trait][:game_trait_id])
    if @trait.id == nil
      @trait.purchases = params[:trait][:purchases]
      if @trait.save
        flash[:success] = "Character updated successfully."
        redirect_to new_character_trait_path(@character)
      else
        flash.now[:alert] = "Error! Please check your input and retry."
        render 'traits/new'
      end
    else
      update
    end
  end

  def new
    @character = Character.find(params[:character_id])
    @trait = Trait.new
    @traits_collection = @character.game.game_traits
  end

  protected

  def update
    @character = Character.find(params[:character_id])
    @trait = Trait.find_or_initialize_by(character: @character, game_trait_id: params[:trait][:game_trait_id])
    @transaction_cost = (GameTrait.find(params[:trait][:game_trait_id]).point_cost * params[:trait][:purchases].to_i)
    @trait.purchases = @trait.purchases + params[:trait][:purchases].to_i
    @trait.points_spent = @trait.points_spent + @transaction_cost
    if @trait.save
      flash[:success] = "Character updated successfully."
      redirect_to new_character_trait_path(@character)
    else
      flash.now[:alert] = "Error! Please check your input and retry."
      render 'new'
    end
  end

  def trait_params
    params.require(:trait).permit(:purchases, :game_trait_id, :character_id)
  end

end

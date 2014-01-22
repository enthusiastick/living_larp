class GameTraitDependenciesController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :show]

  def create
    @game_trait_dependency = GameTraitDependency.new(game_trait_dependency_params)
    if @game_trait_dependency.save
      flash[:success] = "Prerequisite set successfully."
    else
      flash[:alert] = "Error! Unable to set prerequisite."
    end
    redirect_to game_path(Game.find(params[:game_id]))
  end

  def destroy
    @game_trait_dependency = GameTraitDependency.find(params[:id])
    @game = @game_trait_dependency.parent_trait.game
    if @game_trait_dependency.destroy
      flash[:success] = "Prerequisite removed successfully."
    else
      flash[:error] = "Error! Unable to remove prerequisite."
    end
    redirect_to new_game_game_trait_path(@game)
  end

  def new
    @game = Game.find(params[:game_id])
    @game_trait_dependency = GameTraitDependency.new
  end

  protected

  def game_trait_dependency_params
    params.require(:game_trait_dependency).permit(:parent_trait_id, :child_trait_id)
  end

end

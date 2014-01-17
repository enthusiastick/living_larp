class GameTraitDependenciesController < ApplicationController

  def create
    @game_trait_dependency = GameTraitDependency.new(game_trait_dependency_params)
    if @game_trait_dependency.save
      flash[:success] = "Prerequisite set successfully."
    else
      flash[:alert] = "Error! Unable to set prerequisite."
    end
    redirect_to game_path(Game.find(params[:game_id]))
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

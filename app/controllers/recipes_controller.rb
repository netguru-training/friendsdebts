class RecipesController < ApplicationController
  before_action :authenticate_user!
  expose(:group)
  expose(:recipes, ancestor: :group)
  expose(:recipe)

  def index
  end

  def new
    binding.pry
  end

  def create
    # recipe.user = current_user
    # recipe.group = Group.find(params[:id])
    # if recipe.save
    #   redirect_to recipes_path, notice: 'Recipe was successfully created'
    # else
    #   render :new
    # end
  end

  def destroy
    # recipe.destroy
  end

  private
    def recipe_params
      params.require(:recipe).permit(:description, :amount)
    end
end

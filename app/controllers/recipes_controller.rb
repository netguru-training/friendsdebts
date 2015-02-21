class RecipesController < ApplicationController
  before_action :authenticate_user!
  expose(:group)
  expose(:recipes, ancestor: :group)
  expose(:recipe)

  def index
  end

  def new
    group.users.each do |user|
      recipe.recipe_members.build(user: user)
    end
    # binding.pry
  end

  def create
    # binding.pry
    recipe.user = current_user
    if recipe.save
      # binding.pry
      params[:recipe][:users].each do |user_id|
        RecipeMember.create(user_id: user_id, recipe_id: recipe.id) if user_id.to_i > 0
      end
      redirect_to group_recipes_path(group), notice: 'Recipe was successfully created'
    else
      render :new
    end
  end

  def destroy
    # recipe.destroy
  end

  private
    def recipe_params
      params.require(:recipe).permit(:description, :amount, :users)
    end
end

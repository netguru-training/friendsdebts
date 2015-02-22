class RecipesController < ApplicationController
  before_action :authenticate_user!
  expose(:group)
  expose(:recipes, ancestor: :group)
  expose(:recipe, attributes: :recipe_params)
  expose(:permited_users) { group.users.select { |u| u != current_user } }

  def index
  end

  def new
  end

  def create
    recipe.user = current_user
    if recipe.save
      params[:recipe][:users].each do |user_id|
        if user_id.to_i > 0
          RecipeMember.create(user_id: user_id, recipe_id: recipe.id)
          FrindsdebtsMailer.new_debt_email(User.find(user_id), group).deliver
        end
      end
      redirect_to group_path(group)
      flash[:success] = 'Recipe was successfully created'
    else
      render :new
    end
  end

  def destroy
    recipe.destroy
    redirect_to history_path(group)
    flash[:danger] = 'Recipe was deleted'
  end

  private
    def recipe_params
      params.require(:recipe).permit(:description, :amount, :users)
    end
end

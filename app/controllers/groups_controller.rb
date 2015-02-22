class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_in_group, only: [:show]

  expose(:group, attributes: :group_params)
  expose(:recipe)
  expose(:recipes)

  def new
  end

  def show
    group.users.each do |user|
      next if user == current_user
      amount = 0
      # every recipe members for recipes that I created and user is involved with
      additive_recipe_members = RecipeMember.joins("LEFT OUTER JOIN recipes ON recipes.id = recipe_members.recipe_id")
        .where("recipes.user_id = :current_user_id AND recipe_members.user_id = :user_id AND recipes.group_id = :group_id AND recipe_members.balance = FALSE",
            current_user_id: current_user.id,
            user_id: user.id,
            group_id: group.id)
      additive_recipe_members.each do |recipe_member|
        recipe = recipe_member.recipe
        # add one for current_user
        amount += recipe.amount / (recipe.recipe_members.count + 1)
      end
      # binding.pry
      subtraction_recipe_members = RecipeMember.joins("LEFT OUTER JOIN recipes ON recipes.id = recipe_members.recipe_id")
        .where("recipes.user_id = :user_id AND recipe_members.user_id = :current_user_id AND recipes.group_id = :group_id AND recipe_members.balance = FALSE",
          current_user_id: current_user.id,
          user_id: user.id,
          group_id: group.id)
      subtraction_recipe_members.each do |recipe_member|
        recipe = recipe_member.recipe
        # add one for user
        amount -= recipe.amount / (recipe.recipe_members.count + 1)
      end
      # now in amount I have proper value
      user.amount = amount
    end
  end


  def create
    if group.save
      group.users << current_user
      redirect_to group, notice: 'group was successfully created'
    else
      render :new
    end
  end

  def add_user
    @group = Group.find(params[:id])
    @user = User.new
  end

  def create_user
    @group = Group.find(params[:id])
    @user = User.find_by email: user_params[:email]
    if @user && !(@group.users.include?(@user))
      @group.users << @user
      redirect_to group_path(@group)
    else
      @user = User.new(user_params)
      @user.errors.add(:email, 'is not in database')
      render :add_user
    end
  end

  def balance_user
    user = User.find(params[:user_id])
    group = Group.find(params[:id])
    additive_recipe_members = RecipeMember.joins("LEFT OUTER JOIN recipes ON recipes.id = recipe_members.recipe_id")
      .where("recipes.user_id = :current_user_id AND recipe_members.user_id = :user_id AND recipes.group_id = :group_id AND recipe_members.balance = FALSE",
          current_user_id: current_user.id,
          user_id: user.id,
          group_id: group.id)
    subtraction_recipe_members = RecipeMember.joins("LEFT OUTER JOIN recipes ON recipes.id = recipe_members.recipe_id")
      .where("recipes.user_id = :user_id AND recipe_members.user_id = :current_user_id AND recipes.group_id = :group_id AND recipe_members.balance = FALSE",
        current_user_id: current_user.id,
        user_id: user.id,
        group_id: group.id)
    all_members = additive_recipe_members + subtraction_recipe_members
    all_members.map { |e| e.update_attributes(balance: true) }
    redirect_to group_path(group)
  end

  def history
    @recipe_members = RecipeMember.joins("LEFT OUTER JOIN recipes ON recipes.id = recipe_members.recipe_id").where("recipes.user_id = :current_user_id OR recipe_members.user_id = :current_user_id AND recipes.group_id = :group_id", current_user_id: current_user.id, group_id: group.id)
  end


  private

    def group_params
      params.require(:group).permit(:name)
    end

    def user_params
      params.require(:user).permit(:email)
    end

    def authenticate_user_in_group
      unless group.users.include? current_user
        redirect_to root_path
      end
    end
end


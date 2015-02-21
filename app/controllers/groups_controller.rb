class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_in_group, only: [:show]

  expose(:group, attributes: :group_params)

  def new
  end

  def show
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


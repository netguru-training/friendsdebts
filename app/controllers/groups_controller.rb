class GroupsController < ApplicationController
  before_action :authenticate_user!

  expose(:group, attributes: :group_params)

  def new
  end

  def show
  end

  def create
    if group.save
      redirect_to group, notice: 'group was successfully created'
    else
      render :new
    end
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end
end

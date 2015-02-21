class RecipeMember < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user

  def user_email
    user.email
  end
end

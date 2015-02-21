class RecipeMember < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user

  validates :user_id, presence: true
  validates :recipe_id, presence: true

  def user_email
    user.email
  end
end

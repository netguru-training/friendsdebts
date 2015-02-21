class Recipe < ActiveRecord::Base
  belongs_to :groups
  belongs_to :users
  has_many :recipe_members
end

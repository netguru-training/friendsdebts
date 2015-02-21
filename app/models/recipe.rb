class Recipe < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :recipe_members

  attr_accessor :users
end

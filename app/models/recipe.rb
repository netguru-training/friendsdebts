class Recipe < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :recipe_members

  attr_accessor :users

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :group_id, presence: true
  validates :user_id, presence: true
end

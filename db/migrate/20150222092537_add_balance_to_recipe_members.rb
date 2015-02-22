class AddBalanceToRecipeMembers < ActiveRecord::Migration
  def change
    add_column :recipe_members, :balance, :boolean, default: false
  end
end

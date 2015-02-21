class AddBalanceToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :balance, :boolean
  end
end

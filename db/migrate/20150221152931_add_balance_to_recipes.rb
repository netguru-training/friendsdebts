class AddBalanceToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :balance, :boolean, default: false
  end
end

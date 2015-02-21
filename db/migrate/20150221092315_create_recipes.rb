class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :group_id
      t.integer :user_id
      t.string :description
      t.decimal :amount

      t.timestamps
    end
  end
end

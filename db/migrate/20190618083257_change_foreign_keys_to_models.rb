class ChangeForeignKeysToModels < ActiveRecord::Migration[5.2]
  def up
    change_column :purchases, :price, :bigint, limit: 8
    change_column :purchases, :category_id, :bigint, limit: 8
    change_column :purchases, :user_id, :bigint, limit: 8
    change_column :categories, :user_id, :bigint, limit: 8
  end

  def down
    change_column :purchases, :price, :integer
    change_column :purchases, :category_id, :integer
    change_column :purchases, :user_id, :integer
    change_column :categories, :user_id, :integer
  end
end

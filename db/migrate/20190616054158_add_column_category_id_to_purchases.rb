class AddColumnCategoryIdToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :category_id, :integer
  end
end

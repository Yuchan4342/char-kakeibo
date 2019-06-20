class AddIncomeToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :income, :boolean, default: false
  end
end

class AddUserIdToModels < ActiveRecord::Migration[5.2]
  def change
    # 各モデルとユーザを紐付ける.
    add_column :purchases, :user_id, :integer
    add_column :categories, :user_id, :integer
  end
end

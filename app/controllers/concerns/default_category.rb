# frozen_string_literal: true

# default のカテゴリーを作成する Concern.
module DefaultCategory
  extend ActiveSupport::Concern

  # default のカテゴリーを作成する.
  def create_default_category
    # ユーザに紐づくカテゴリーが 1つもない場合のみ実行.
    return if Category.where(user: current_user).count.positive?

    Category.create(name: '未定', user: current_user)
    Category.create(name: '収入', user: current_user)
    Category.create(name: '食費', user: current_user)
    Category.create(name: '交通', user: current_user)
    Category.create(name: '買い物', user: current_user)
  end
end

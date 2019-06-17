# frozen_string_literal: true

# == Schema Information
#
# Table name: purchases
#
#  id          :bigint           not null, primary key
#  name        :string
#  price       :integer
#  bought_at   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer
#

# Purchase model. 購入などの取引を表すモデル.
class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :bought_at, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :user_id, presence: true
  validate :belongs_to_same_user?

  # Purchase と Category が同じ User に紐付いているかチェック.
  def belongs_to_same_user?
    user_id == category&.user_id || category.nil?
  end
end

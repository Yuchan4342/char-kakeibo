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
  validates :price, presence: true
  validates :user_id, presence: true
end

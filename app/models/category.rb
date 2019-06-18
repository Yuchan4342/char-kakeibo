# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#

# Category model. 費目を表すモデル.
class Category < ApplicationRecord
  belongs_to :user
  has_many :purchases, dependent: :nullify, inverse_of: :category
  validates :name, presence: true
  validates :user_id, presence: true
end

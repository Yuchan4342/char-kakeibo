# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Category model. 費目を表すモデル.
class Category < ApplicationRecord
  has_many :purchases, dependent: :nullify, inverse_of: :category
end

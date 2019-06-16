# frozen_string_literal: true

# == Schema Information
#
# Table name: purchases
#
#  id         :bigint           not null, primary key
#  name       :string
#  price      :integer
#  bought_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Purchase model. 購入などの取引を表すモデル.
class Purchase < ApplicationRecord
end

# frozen_string_literal: true

# PurchaseController
# 購入 Purchase に関連する Controller.
class PurchaseController < ApplicationController
  def index
    @purchases = Purchase.all
  end
end

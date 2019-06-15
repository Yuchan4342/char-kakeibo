# frozen_string_literal: true

# PurchaseController
# 購入 Purchase に関連する Controller.
class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.all
  end

  def new
    @purchase = Purchase.new
  end
end

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

  def create
    # エラー時の render 用に、@purchase を作成しておく.
    @purchase = Purchase.new(params[:purchase])
    respond_to do |format|
      if @purchase.save
        format.html do
          redirect_to @purchase, notice: 'Purchase was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end
end

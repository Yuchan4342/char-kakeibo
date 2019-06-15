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
    @purchase = Purchase.new(purchase_params)
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to purchases_path }
      else
        format.html { render :new }
      end
    end
  end

  private

  def purchase_params
    purchase_params = params[:purchase]&.permit!
    purchase_params['bought_at'] = purchase_params['bought_at(1i)']
    purchase_params['bought_at'] << '-'
    purchase_params['bought_at'] << purchase_params['bought_at(2i)']
    purchase_params
  end
end

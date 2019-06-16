# frozen_string_literal: true

# PurchaseController
# 購入 Purchase に関連する Controller.
class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[edit update destroy]

  def index
    @purchases = Purchase.eager_load(:category).order('bought_at DESC')
  end

  def new
    @purchase = Purchase.new(price: 0)
  end

  def edit; end

  def create
    # エラー時の render 用に、@purchase を作成しておく.
    @purchase = Purchase.new(purchase_params)
    respond_to do |format|
      if @purchase.save
        format.html do
          redirect_to(purchases_path,
                      notice: t('.successfully_created',
                                default: 'Purchase was successfully created.'))
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html do
          redirect_to(purchases_path,
                      notice: t('.successfully_updated',
                                default: 'Purchase was successfully updated.'))
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html do
        redirect_to(purchases_path,
                    notice: t('.successfully_destroyed',
                              default: 'Purchase was successfully destroyed.'))
      end
    end
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params[:purchase]&.permit!
  end
end

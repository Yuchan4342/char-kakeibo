# frozen_string_literal: true

# PurchaseController
# 購入 Purchase に関連する Controller.
class PurchasesController < ApplicationController
  include DefaultCategory

  before_action :authenticate_user!
  before_action :set_purchase, only: %i[edit update destroy]
  before_action :set_search_date, only: [:index]
  before_action :create_default_category, only: %i[new edit]

  def index
    @purchases = Purchase.where(user: current_user,
                                category: @search_category_id,
                                bought_at: @search_date.in_time_zone.all_month)
                         .eager_load(:category).order('bought_at DESC')
    @income = @purchases.select(&:income).sum(&:price)
    @spend = @purchases.reject(&:income).sum(&:price)
  end

  def new
    @purchase = Purchase.new(price: 0)
  end

  def edit; end

  def create
    # エラー時の render 用に、@purchase を作成しておく.
    @purchase = Purchase.new(purchase_params)
    @purchase.user = current_user
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
    # 自分以外の Purchase を編集/削除などできないようにチェック.
    return if @purchase.user_id == current_user.id

    # purchases#index に飛ばす. TODO: i18n 対応.
    redirect_to(purchases_path, notice: '権限がありません。')
  end

  # パラメータから表示する月を設定する. パラメータがない場合は今月のデータを表示.
  def set_search_date
    search_params = params[:search]
    @search_date = if search_params.nil?
                     Time.zone.today
                   else
                     @search_date = Date.new(search_params[:"date(1i)"].to_i,
                                             search_params[:"date(2i)"].to_i)
                   end
    @search_category_id = search_params&.[](:category)
  end

  def purchase_params
    params[:purchase]&.permit!
  end
end

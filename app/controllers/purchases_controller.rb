# frozen_string_literal: true

# PurchaseController
# 購入 Purchase に関連する Controller.
class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase, only: %i[edit update destroy]
  before_action :set_categories, only: [:index]
  before_action :set_search_date, only: [:index]
  before_action :set_selected_category, only: [:index]

  def index
    @purchases = Purchase.where(user: current_user,
                                category: @search_category,
                                bought_at: @range)
                         .eager_load(:category).order('bought_at DESC')
    # 選択した月. 年間の場合は空文字列.
    @selected_month = @all_year ? '' : @search_date.month
    # タイトル行で表示する文字列.
    @title_month = l(@search_date, format: (@all_year ? :year : :month))
    # 対象期間での収入/支出.
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

  def set_categories
    @categories = Category.where(user: current_user)
  end

  # パラメータから表示する年月を設定する. パラメータがない場合は今月のデータを表示.
  def set_search_date
    search_params = params[:search]
    if search_params.nil?
      @search_date = Time.zone.today
      @all_year = false
    else
      # 年間指定の場合は 0が入る.
      month = search_params[:month].to_i
      @search_date = Date.new(search_params[:year].to_i,
                              (month.positive? ? month : 1))
      # 年間指定なら true.
      @all_year = month.zero?
    end
    set_date_range
  end

  # 表示する日付の範囲を設定.
  def set_date_range
    @range = if @all_year
               @search_date.in_time_zone.all_year
             else
               @search_date.in_time_zone.all_month
             end
  end

  # パラメータから表示するカテゴリーを設定する. パラメータがない場合は全カテゴリー.
  def set_selected_category
    @selected_category_id = params[:search]&.[](:category)
    @search_category = if @selected_category_id.present?
                         @selected_category_id.to_i
                       else
                         @categories.map(&:id)
                       end
  end

  def purchase_params
    params[:purchase]&.permit!
  end
end

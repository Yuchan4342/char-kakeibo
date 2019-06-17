# frozen_string_literal: true

# CategoriesController
# カテゴリー Categories に関連する Controller.
class CategoriesController < ApplicationController
  include DefaultCategory

  before_action :authenticate_user!
  before_action :set_category, only: %i[edit update destroy]
  before_action :create_default_category, only: %i[index]

  def index
    @categories = Category.where(user: current_user)
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    # エラー時の render 用に、@category を作成しておく.
    @category = Category.new(category_params)
    @category.user = current_user
    respond_to do |format|
      if @category.save
        format.html do
          redirect_to(categories_path,
                      notice: t('.successfully_created',
                                default: 'Category was successfully created.'))
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html do
          redirect_to(categories_path,
                      notice: t('.successfully_updated',
                                default: 'Category was successfully updated.'))
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html do
        redirect_to(categories_path,
                    notice: t('.successfully_destroyed',
                              default: 'Category was successfully destroyed.'))
      end
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
    # 自分以外の Category を編集/削除などできないようにチェック.
    return if @category.user_id == current_user.id

    # categories#index に飛ばす. TODO: i18n 対応.
    redirect_to(categories_path, notice: '権限がありません。')
  end

  def category_params
    params[:category]&.permit!
  end
end

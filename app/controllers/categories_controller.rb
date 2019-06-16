# frozen_string_literal: true

# CategoriesController
# カテゴリー Categories に関連する Controller.
class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    # エラー時の render 用に、@category を作成しておく.
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html do
          redirect_to categories_path,
                      notice: 'Category was successfully created.'
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
          redirect_to categories_path,
                      notice: 'Category was successfully updated.'
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
        redirect_to categories_path,
                    notice: 'Category was successfully destroyed.'
      end
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params[:category]&.permit!
  end
end

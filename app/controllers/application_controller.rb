# frozen_string_literal: true

# ApplicationController.
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # 新規登録/アカウント更新時(sign_up/account_update 時)に name というキーのパラメーターを追加で許可する.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end

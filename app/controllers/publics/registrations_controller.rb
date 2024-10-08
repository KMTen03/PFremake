# frozen_string_literal: true

class Publics::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  before_action :ensure_normal_user, only: [:edit, :update, :destroy]
  
  def ensure_normal_user #ゲストユーザーがパスワードを変更できないようにする
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除できません。'
    end
  end

  # protected
  
  # def configure_sign_up_params #新規登録には名前とメアドが必要
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  # end
end


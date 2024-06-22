# frozen_string_literal: true

class Publics::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def guest_sign_in
    @user = User.guest
    sign_in @user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def user_state
    @user = user.find_by(email: params[:user][:email])
    if @user.valid_password?(params[:user][:password]) && @user.is_deleted
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_user_session_path
    end
  end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end

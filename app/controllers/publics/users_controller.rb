class Publics::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit, :update, :withdraw]
  before_action :matching_login_user, only: [:edit, :update, :withdraw]

  def show
    @user = current_user
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    redirect_to new_user_session_path, notice: '退会処理を実行しました。'
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduce, :profile_image)
  end

  def current_user
    @user = current_user
    @user = User.find(params[:id])
  end

  def matching_login_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end

  def guest_sign_in
    @user = User.guest
    sign_in user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def ensure_guest_user
   if current_user.guest_user?
     redirect_to root_path, notice: "ゲストユーザーはプロフィール編集できません。"
   end
  end

  def ranking
    @user_ranks = User.ranking
  end
end

# 使う可能性があるためコメントアウトで残します
  # def likes
  #   @user = User.find(params[:id])
  #   likes = Like.where(user_id: current_user.id).pluck(:post_id)
  #   @likes_posts = Post.find(likes)
  #   @likes_posts = Kaminari.paginate_array(@likes_posts).page(params[:page]).per(5)
  # end
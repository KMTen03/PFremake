class Publics::FavoritesController < ApplicationController
  def create
    @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id]) 
    #ログイン中のユ－ザーidを指定する。
    #post_id には、ルーティングに含めた:post_idを指定する。
    @post_favorite.save
    #saveメソッドでデータベースへ保存する
    redirect_to post_path(params[:post_id]) 
    #再度投稿詳細画面へリダイレクトする。
  end

  def destroy
    @post_favorite = favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    #ログイン中のユ－ザーidを指定する。
    #post_id には、ルーティングに含めた:post_idを指定する。
    @post_favorite.destroy
    #destroyメソッドでデータベースのレコードを削除する
    redirect_to post_path(params[:post_id])
    #再度投稿詳細画面へリダイレクトする。
  end
end

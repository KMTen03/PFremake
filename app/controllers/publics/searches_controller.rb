class Publics::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @range = params[:range]
    @word = params[:word]
    
    if @range == "User"
      @posts = Post.looks(params[:search], params[:word])
    else
      @tags = Tag.looks(params[:search], params[:word])
    end
  end
end

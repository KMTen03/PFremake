class Publics::TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post.save_tags(params[:post][:tag])
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to tags_path
  end
end

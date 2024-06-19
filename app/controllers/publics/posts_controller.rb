class Publics::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def index
    @post = Post.new
    @posts = Post.page(params[:page]).per(10)
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = 'ModelClassName was successfully updated.'
      @post.save_tags(params[:post][:tag])
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).destroy()
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :time, :tag, tag_ids: [])
  end
end

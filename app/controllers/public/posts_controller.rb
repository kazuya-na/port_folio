class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
       flash[:notice] = '投稿しました。'
       redirect_to posts_path
    else
      @posts = Post.all
      render 'new'
    end
  end

  def index
    @post = Post.new
    @posts = Post.all
  end

  def show
    @post_new = Post.new
    @post = Post.find(params[:id])
    @end_user = EndUser.find(@post.end_user.id)
    @post_comment = PostComment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:alert] = '投稿を削除しました。'
    redirect_to request.referer
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end

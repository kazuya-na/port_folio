class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
       redirect_to post_path(@post), notice: "You have created book successfully."
    else
      @posts = Post.all
      render 'index'
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
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end

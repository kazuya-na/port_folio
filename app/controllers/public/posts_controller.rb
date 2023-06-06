class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @post = Post.new
    @posts = Post.all
  end


  def create
    @post = Post.new(post_params)
    if @post.save
       redirect_to posts_path
    else
       render 'new'
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end

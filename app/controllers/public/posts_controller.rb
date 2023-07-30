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
      render 'new'
    end
  end

  def index
    @posts = Post.joins(:end_user).where(end_users: { is_deleted: false }).page(params[:page]).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.joins(:end_user).where(end_users: { is_deleted: false }).page(params[:page]).order(created_at: :desc)
  end

  def destroy
    # 他人が削除でき脆弱になっている
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

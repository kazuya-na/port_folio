class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = current_end_user.post_comments.new(post_comment_params)
    @comment.post_id = post.id
    @comment.save
    flash[:notice] = 'コメントの送信に成功しました。'
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.post_comments.find(params[:id])
    comment.destroy
    flash[:alert] = 'コメントを削除しました。'
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:end_user_id, :post_id, :body)
  end
end

class Public::EndUsersController < ApplicationController
  before_action :set_end_user, only: [:favorites]
  before_action :ensure_guest_end_user, only: [:edit]
  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
    unless @end_user.id == current_end_user.id
      redirect_to end_user_path(current_end_user.id)
    end
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(@end_user.id), notice: "内容を更新しました"
    else
      render :edit
    end
  end

  def withdraw_confirm
  end


  def withdraw
    @user = current_end_user
    @user.update(is_deleted: true)
    reset_session
    flash[:alert] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def favorites
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:nick_name, :gender, :date_of_birth, :introduction, :is_deleted, :email, :encrypted_password, :profile_image)
  end

  def set_end_user
    @end_user = EndUser.find(params[:id])
  end

  def ensure_guest_end_user
    @end_user = EndUser.find(params[:id])
    if @end_user.nick_name == "guestuser"
      redirect_to root_path
    end
  end
end

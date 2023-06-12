class Public::EndUsersController < ApplicationController
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
      redirect_to end_user_path(@end_user.id), notice: "You have updated user successfully."
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

  private

  def end_user_params
    params.require(:end_user).permit(:nick_name, :gender, :date_of_birth, :introduction, :is_deleted, :email, :encrypted_password)
  end
end

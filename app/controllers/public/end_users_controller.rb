class Public::EndUsersController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  def withdraw_confirm
  end


  def withdraw
    @user = current_end_user
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:alert] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def end_user_params
    params.require(:end_user).permit(:nick_name, :gender, :date_of_birth, :introduction, :is_deleted, :email, :encrypted_password)
  end
end

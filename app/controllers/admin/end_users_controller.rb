class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @end_users = EndUser.page(params[:page]).order(created_at: :desc)
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path
    else
      render :edit
    end
  end

# ユーザーの退会確認画面を表示させるためwithdraw_confirm,withdrawを
  def withdraw_confirm
  end

  def withdraw
  end

  private

  def end_user_params
    params.require(:end_user).permit(:nick_name, :gender, :date_of_birth, :introduction, :is_deleted, :email, :encrypted_password, :profile_image)
  end
end

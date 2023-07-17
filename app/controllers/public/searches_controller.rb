class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!
  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "EndUser"
      @end_users = EndUser.where(end_users: { is_deleted: false }).looks(params[:search], params[:word]).order(created_at: :desc)
    else
      @posts = Post.joins(:end_user).where(end_users: { is_deleted: false }).looks(params[:search], params[:word]).order(created_at: :desc)
    end
  end
end

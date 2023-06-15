class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
  end

  def update
  end
end

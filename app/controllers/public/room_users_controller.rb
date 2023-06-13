class Public::RoomUsersController < ApplicationController
  def index
  end

  def show
  end

  private

  def room_user_params
    params.require(:room_user).permit(:end_user_id, :chat_room_id)
  end
end

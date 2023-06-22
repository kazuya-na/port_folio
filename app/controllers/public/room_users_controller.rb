class Public::RoomUsersController < ApplicationController
  def create
  end
  
  def destroy
  end

  private

  def room_user_params
    params.require(:room_user).permit(:end_user_id, :chat_room_id)
  end
end

class Public::ChatRoomsController < ApplicationController
  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    @chat_room.end_user_id = current_end_user.id
    if @chat_room.save
    redirect_to chat_room_path(@chat_room)
  else
    redirect_to request.referer
  end
  end

  def index
    @chat_rooms = ChatRoom.all
  end

  def show
    @chat_room_new = ChatRoom.new
    @chat_room = ChatRoom.find(params[:id])
  end

  def destroy
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:end_user_id, :title, :introduction)
  end
end

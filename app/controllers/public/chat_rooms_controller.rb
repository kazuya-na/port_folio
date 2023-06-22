class Public::ChatRoomsController < ApplicationController

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    @chat_room.end_user_id = current_end_user.id
    if @chat_room.save
       flash[:notice] = 'チャットルームの作成に成功しました。'
       redirect_to chat_room_path(@chat_room)
    else
      @chat_rooms = ChatRoom.all
      render 'new'
    end
  end

  def index

    @chat_rooms = ChatRoom.joins(:end_user).where(end_users: { is_deleted: false }).page(params[:page]).order(created_at: :desc)
  end

  def show
    @chat_message = ChatMessage.new
    @chat_room = ChatRoom.find(params[:id])
    @chat_messages = ChatMessage.where(chat_room: @chat_room)
  end

  def destroy
    chat_room = ChatRoom.find(params[:id])
    chat_room.destroy
    flash[:alert] = 'チャットルームを削除しました。'
    redirect_to request.referer
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:end_user_id, :title, :introduction)
  end
end

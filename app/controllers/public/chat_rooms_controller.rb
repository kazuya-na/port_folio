class Public::ChatRoomsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :correct_chat_room, only: [:show]

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
    @chat_room = ChatRoom.find(params[:id])
    @chat_message = ChatMessage.new
    @chat_messages = ChatMessage.where(chat_room: @chat_room).order(created_at: :desc)
  end

  def destroy
    chat_room = ChatRoom.find(params[:id])
    chat_room.destroy
    flash[:alert] = 'チャットルームを削除しました。'
    redirect_to request.referer
  end

  def correct_chat_room
    @chat_room = ChatRoom.find(params[:id])
    unless @chat_room.end_user.id == current_end_user.id || (current_end_user.following?(@chat_room.end_user) && @chat_room.end_user.following?(current_end_user))
      redirect_to chat_rooms_path
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:end_user_id, :title, :introduction)
  end
end

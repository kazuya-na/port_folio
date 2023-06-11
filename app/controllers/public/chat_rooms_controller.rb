class Public::ChatRoomsController < ApplicationController
  def new
    @chat_room = ChatRoom.new
  end

  def create
    current_end_users_chat_rooms = RoomUser.where(end_user_id: current_end_user.id).map do |room_user|
      room_user.chat_room
    end
    chat_room = RoomUser.where(chat_room_id: current_end_users_chat_rooms,end_user_id: params[:end_user_id])[0].chat_room
    if chat_room.blank?
        chat_room = ChatRoom.create
        RoomUser.create(end_user_id: current_end_user.id, chat_room_id: chat_room.id)
        RoomUser.create(end_user_id: params[:end_user_id], chat_room_id: chat_room.id)
    end
    redirect_to chat_room_path(chat_room)
  end

  def index
    @chat_rooms = ChatRoom.all
  end

  def show
    #フォームに渡すために、モデルのインスタンスを作成。
    @chat_message=ChatMessage.new
    #受け取ったクエリパラメータでチャットルームオブジェクトを取得。
    @chat_room=ChatRoom.find(params[:id])
    #表示するチャットルーム内でのメッセージを全件配列で取得。
    @chat_messages=ChatMessage.where(chat_room: @chat_room)
    #チャット相手ユーザーの取得。
    @chat_room_user=@chat_room.chat_room_users.where.not(user_id: current_user.id)[0].user
  end

  def destroy
    @chat_room = ChatRoom.find(params[:id])
    @chat_room.destroy
    flash[:notice] = '商品を削除しました。'
    redirect_to request.referer
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:end_user_id, :title, :introduction)
  end
end

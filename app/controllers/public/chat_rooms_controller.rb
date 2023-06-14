class Public::ChatRoomsController < ApplicationController
  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    @chat_room.end_user_id = current_end_user.id
    if @chat_room.save
       redirect_to chat_room_path(@chat_room), notice: "You have created book successfully."
    else
      @chat_rooms = ChatRoom.all
      render 'index'
    end
  end

  def index
    @chat_rooms = ChatRoom.all
  end

  def show
    #フォームに渡すために、モデルのインスタンスを作成。
    @chat_message = ChatMessage.new
    #受け取ったクエリパラメータでチャットルームオブジェクトを取得。
    @chat_room = ChatRoom.find(params[:id])
    #表示するチャットルーム内でのメッセージを全件配列で取得。
    @chat_messages = ChatMessage.where(chat_room: @chat_room)
  end

  def destroy
    chat_room = ChatRoom.find(params[:id])
    chat_room.destroy
    flash[:notice] = 'チャットルームを削除しました。'
    redirect_to request.referer
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:end_user_id, :title, :introduction)
  end
end

class Public::ChatMessagesController < ApplicationController
  def create
    #フォームから受け取った値でチャットルームオブジェクトを取得
    @chat_room = ChatRoom.find(params[:chat_message][:chat_room_id])
    #フォームから受け取った値で、チャットメッセージオブジェクトを作成
    @chat_message = current_end_user.chat_messages.new(chat_message_params)
    if @chat_message.save
        flash[:notice] = "メッセージの送信に成功しました。"
        redirect_to request.referer
    else
        flash[:alert] = "メッセージの送信に失敗しました。"
        redirect_to chat_room_path(@chat_room)
    end
  end

  def show
    @chat_room_find = ChatRoom.find(params[:id])
    @end_user = EndUser.find(params[:id])
    chat_rooms = current_end_user.room_users.pluck(:chat_room_id)
    room_users = RoomUser.find_by(end_user_id: @end_user.id, chat_room_id: chat_rooms)

    unless room_users.nil?
      @chat_room = room_users.chat_room
    else
      @chat_room = ChatRoom.new
      @chat_room.save
      RoomUser.create(end_user_id: current_end_user.id, chat_room_id: @chat_room.id)
      RoomUser.create(end_user_id: @end_user.id, chat_room_id: @chat_room.id)
    end
    @chat_messages = @chat_room.chat_messages
    @chat_message = ChatMessage.new(chat_room_id: @chat_room.id)
  end

  def destroy
    @chat_room = ChatRoom.find(params[:chat_room_id])
    message = @chat_room.chat_messages.find(params[:id])
    message.destroy
    flash[:notice] = 'コメントを削除しました。'
    redirect_to request.referer
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:end_user_id, :chat_room_id, :body)
  end
end

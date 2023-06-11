class Public::ChatMessagesController < ApplicationController
  def create
    #フォームから受け取った値でチャットルームオブジェクトを取得
    @chat_room = ChatRoom.find(params[:chat_message][:chat_room_id])
    #フォームから受け取った値で、チャットメッセージオブジェクトを作成
    @chat_message = ChatMessage.new(chat_message_params)
    if @chat_message.save
        flash[:notice] = "メッセージの送信に成功しました。"
        redirect_to chat_room_path(@chat_room)
    else
        flash[:alert] = "メッセージの送信に失敗しました。"
        redirect_to chat_room_path(@chat_room)
    end
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
  end

  def destroy
  end

  def chat_message_params
    params.require(:chat_message).permit(:end_user_id, :chat_room_id, :body)
  end
end

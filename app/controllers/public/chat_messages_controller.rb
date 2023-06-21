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

  def destroy
    @chat_room = ChatRoom.find(params[:chat_room_id])
    message = @chat_room.chat_messages.find(params[:id])
    message.destroy
    flash[:alert] = 'コメントを削除しました。'
    redirect_to request.referer
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:end_user_id, :chat_room_id, :body)
  end
end

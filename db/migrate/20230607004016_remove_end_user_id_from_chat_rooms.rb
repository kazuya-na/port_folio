class RemoveEndUserIdFromChatRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :chat_rooms, :name, :integer
  end
end

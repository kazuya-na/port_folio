class AddEndUserIdToChatRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :chat_rooms, :name, :integer
  end
end

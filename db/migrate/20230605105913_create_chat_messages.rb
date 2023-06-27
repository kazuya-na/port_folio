class CreateChatMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_messages do |t|

      t.timestamps
      t.integer :end_user_id, null: false
      t.integer :chat_room_id, null: false
      t.text :body, null: false
    end
  end
end

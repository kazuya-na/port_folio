class CreateRoomUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :room_users do |t|

      t.timestamps
      t.integer :end_user_id, null: false
      t.integer :chat_room_id, null: false
    end
  end
end

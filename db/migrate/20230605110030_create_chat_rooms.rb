class CreateChatRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_rooms do |t|

      t.timestamps
      t.integer :end_user_id, null: false
      t.string :title, null: false
      t.text :introduction, null: false
    end
  end
end

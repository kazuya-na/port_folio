class AddBodyToChatMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :chat_messages, :body, :text
  end
end

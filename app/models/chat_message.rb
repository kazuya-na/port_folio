class ChatMessage < ApplicationRecord
  belongs_to :end_user
  belongs_to :chat_room

  validates :body, presence:true, length:{maximum:200}
end

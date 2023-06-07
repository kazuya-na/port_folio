class ChatMessage < ApplicationRecord
  belongs_to :end_user
  belongs_to :chat_room
end

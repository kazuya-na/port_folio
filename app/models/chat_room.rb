class ChatRoom < ApplicationRecord
  has_many :chat_messages, dependent: :destroy
  has_many :chat_room_users, class_name: 'RoomUser', foreign_key: 'chat_room_id', dependent: :destroy
  belongs_to :end_user

  has_many :end_users, through: :chat_room_users, source: :end_user
end

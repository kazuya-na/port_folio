class RoomUser < ApplicationRecord
  belongs_to :end_user, class_name: 'EndUser'
  belongs_to :chat_room, class_name: 'ChatRoom'
end

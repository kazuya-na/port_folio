class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diaries, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :chat_messages, dependent: :destroy
  has_many :room_users, class_name: 'RoomUser',foreign_key: 'end_user_id', dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :favorited_posts, through: :favorites, source: :post
  has_many :chat_users, through: :room_users, source: :chat_room
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  enum gender: { gender_private: 0, male: 1, female: 2, others: 3 }
end

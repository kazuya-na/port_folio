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

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow(end_user_id)
    active_relationships.create(followed_id: end_user_id)
  end

  def unfollow(end_user_id)
    active_relationships.find_by(followed_id: end_user_id).destroy
  end

  def following?(end_user)
    followings.include?(end_user)
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @end_user = EndUser.where("nick_name LIKE?", "#{word}")
    elsif search == "forward_match"
      @end_user = EndUser.where("nick_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @end_user = EndUser.where("nick_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @end_user = EndUser.where("nick_name LIKE?","%#{word}%")
    else
      @end_user = EndUser.all
    end
  end

  enum gender: { gender_private: 0, male: 1, female: 2, others: 3 }
end

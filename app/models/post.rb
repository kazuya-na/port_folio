class Post < ApplicationRecord
  belongs_to :end_user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :favorited_users, through: :fovorites, source: :end_user

  def favorited_by?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end
end

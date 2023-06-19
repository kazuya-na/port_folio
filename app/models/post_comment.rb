class PostComment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post

  validates :body, presence:true, length:{maximum:200}
end

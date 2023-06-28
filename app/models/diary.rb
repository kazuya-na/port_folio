class Diary < ApplicationRecord
  belongs_to :end_user

  validates :date, presence:true
end

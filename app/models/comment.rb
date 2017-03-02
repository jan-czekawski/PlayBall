class Comment < ApplicationRecord
  belongs_to :court
  belongs_to :user
  validates :user_id, presence: true
  validates :court_id, presence: true
  validates :content, presence: true
end 
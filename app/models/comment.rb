class Comment < ApplicationRecord
  belongs_to :court
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :court_id, presence: true
  validates :content, presence: true
end 
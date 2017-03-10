class Comment < ApplicationRecord
  belongs_to :court, :foreign_key => :court_id
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :court_id, presence: true
  validates :content, presence: true
end 
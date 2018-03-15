class Comment < ApplicationRecord
  belongs_to :court, foreign_key: :court_id
  belongs_to :user
  default_scope -> { order(updated_at: :desc) }
  validates :content, presence: true
  
  def display_errors
    error = "There is an error. "
    errors.full_messages.each { |msg| error << msg + ". " }
    error
  end
end

class Comment < ApplicationRecord
  # TODO: make comments dependant on courts and users
  # TODO: on show courts template show only created at date of courts
  belongs_to :court, foreign_key: :court_id
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true
  
  def display_errors
    error = "There is an error. "
    errors.full_messages.each { |msg| error << msg + ". " }
    error
  end
end

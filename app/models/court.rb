class Court < ActiveRecord::Base
  belongs_to :user
  include ApplicationHelper
  default_scope -> { order(updated_at: :desc) }
  has_many :comments, dependent: :destroy
  validates :name, presence: true, 
                   length: { maximum: 255 }
  # validates :picture, presence: true
  mount_uploader :picture, PictureUploader
  validate :picture_size
  validates :description, presence: true
  validates :user_id, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

end
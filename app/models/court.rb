class Court < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :name, presence: true, 
                   length: { maximum: 255 }
  validates :picture, presence: true
  mount_uploader :picture, PictureUploader
  validate :picture_size
  validates :description, presence: true
  validates :user_id, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
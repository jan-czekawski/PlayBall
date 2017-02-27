class Court < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, 
                   length: { maximum: 100 }
  # validates :picture, presence: true
  mount_uploader :picture, PictureUploader
  # validate :picture_size
  validates :description, presence: true,
                          length: { maximum: 300 }
  validates :user_id, presence: true

  private

  # def picture_size
  #   if self.picture.size > 5.megabytes
  #     errors.add(:picture, "should be less than 5MB")
  #   end
  # end
end
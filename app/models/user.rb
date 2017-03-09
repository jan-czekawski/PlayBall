class User < ApplicationRecord

  has_many :courts, dependent: :destroy
  has_many :comments, dependent: :destroy
  before_save { self.email = email.downcase }
  validates :username, presence: true,
                       length: { maximum: 50}
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    length: { maximum: 255 }, 
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, allow_nil: true
  validates_confirmation_of :password, allow_nil: true
end

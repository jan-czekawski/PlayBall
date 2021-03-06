class User < ApplicationRecord
  # TODO: index  users template doesn't show the whole card -> it will after refresh, check js and css
  # TODO: skip user email activation => just add note that it's possible
  # TODO: check assets precompile etc
  attr_accessor :remember_token, :activation_token, :reset_token
  include ApplicationHelper
  before_create :create_activation_digest
  before_save :email_downcase
  has_many :courts, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :username, presence: true,
                       length: { maximum: 50}
  mount_uploader :picture, PictureUploader
  validate :picture_size                  
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    length: { maximum: 255 }, 
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, allow_nil: true
  validates_confirmation_of :password, allow_nil: true

  # ENCRYPT THE STRING, USING MINIMAL COST IF POSSIBLE
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # GENERATE NEW TOKEN
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # SAVE THAT TOKEN AS A REMEMBER TOKEN, ENCRYPT IT COPY AND SAVE IT IN DIGEST
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # CHECK IF DIGEST AND TOKEN ARE THE SAME
  def authenticated?(type, token)
    digest = self.send("#{type}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # FORGET THE DIGEST
  def forget
    update_attribute(:remember_digest, nil)
  end

  # BEFORE SAVING CHANGE ALL CHARACTERS TO LOWERCASE
  def email_downcase
    self.email = email.downcase 
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_at: Time.now)
  end




  private

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end


end

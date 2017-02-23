class Court < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, 
                   length: { maximum: 100 }
  validates :picture, presence: true
  validates :description, presence: true,
                          length: { maximum: 300 }
  validates :user_id, presence: true
end
class Picture < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user
  validates :title, presence: true
  mount_uploader :image, ImageUploader
end

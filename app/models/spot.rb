class Spot < ApplicationRecord
  validates :name, presence: true
  validates :position, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  
  has_many :posts, dependent: :destroy
end

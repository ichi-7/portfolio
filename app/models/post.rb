class Post < ApplicationRecord
  validates :title, presence: true
  validates :info, presence: true
  
  has_one_attached :image
  belongs_to :user
  belongs_to :spot
end

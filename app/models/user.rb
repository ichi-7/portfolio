class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :plan_members, dependent: :destroy
  has_many :group_chats, dependent: :destroy
         
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end
  
end

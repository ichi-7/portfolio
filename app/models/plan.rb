class Plan < ApplicationRecord
  
  validates :plan_name, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  validates :meeting_place, presence: true
  validates :meeting_time, presence: true
  
  has_one_attached :image
  belongs_to :user
  has_many :places, dependent: :destroy
  has_many :plan_members, dependent: :destroy
  has_many :group_chats, dependent: :destroy
  
  def member?(user)
    plan_members.where(user_id: user.id).exists?
  end
  
end

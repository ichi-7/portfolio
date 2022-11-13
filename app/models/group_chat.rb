class GroupChat < ApplicationRecord
  
  belongs_to :user
  belongs_to :plan, optional: true
  
end

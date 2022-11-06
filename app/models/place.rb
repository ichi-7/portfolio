class Place < ApplicationRecord
  
  belongs_to :plan
  geocoded_by :address # addressカラムを基準に緯度経度を算出
  after_validation :geocode # 住所変更時に緯度経度も変更
  
end

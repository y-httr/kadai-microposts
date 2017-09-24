class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true #ユーザの紐付けなしにモデルを保存できない
  validates :content, presence: true, length: { maximum: 255 }
  
  #お気に入り機能
  has_many :favorites
  has_many :favorites_user, through: :favorites, source: :user 
  
end

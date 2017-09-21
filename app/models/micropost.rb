class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true #ユーザの紐付けなしにモデルを保存できない
  validates :content, presence: true, length: { maximum: 255 }
end

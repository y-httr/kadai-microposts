class Relationship < ApplicationRecord
  belongs_to :user #Userクラスに所属する
  belongs_to :follow, class_name: 'User' #FollowとはUserクラスのことですよ
  
  validates :user_id, presence: true
  validates :follow_id, presence: true
  
end

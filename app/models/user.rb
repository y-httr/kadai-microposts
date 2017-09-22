class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts #対象のモデルは複数形になる事に注意
  
  #中間テーブルの先のモデルを参照できる:followingsはここで命名
  #sourceには，中間テーブルのカラムのどのIDを参照先とするかを指定
  has_many :relationships #UserとRelationshipは1対多
  has_many :followings, through: :relationships, source: :follow
  
  #:reverses_of_relationshipなんて名前はないが,クラスを直接指定(:relationshipsと別の名前にするため)
  #Rails の命名規則により、User から Relationship を取得するとき、user_id(左側の値) にアクセスする
  #foreign_key: "follow_id"を指定するとfollow_id（右側の値）にアクセスした中間テーブルとなる
  has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user #user.follow(other)を実行した時にuserインスタンスが入る
      #find_or_create_byは見つかればrelationを返し，なければフォームを作成し保存する
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship #relationshipがnilでなければ削除
  end
  
  def following?(other_user)
    #followしているユーザを取得してその要素にother_userが含まれているか確認する
    self.followings.include?(other_user) 
  end
end


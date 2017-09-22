class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      #下記foreign_keyはuser_idカラムを生成し，外部キーとしてusersテーブルを参照（default）
      t.references :user, foreign_key: true
      #下記foreing_keyはfollows_idカラムを生成し，外部キーとしてusersテーブルを参照
      #参照テーブル名(小文字複数)を明示的に指定
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps
      #フォロー中の二度目のフォローを防ぐ(重複するものが保存されない)
      t.index [:user_id, :follow_id], unique: true
    end
  end
end

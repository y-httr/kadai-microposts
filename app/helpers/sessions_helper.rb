module SessionsHelper
  def current_user
    #現在ログインしているユーザを取得するメソッド
    #||=は左辺がnilかfalseなら右辺を代入する
    #つまりすでにログインユーザが代入されていたら何もしない
    #find_byはなくてもnilを返すだけでエラーが発生しない
    @current_user ||= User.find_by(id: session[:user_id])
  end
   def logged_in?
     #ログインしてるかどうかを判定する
     #ログインしていなければcurrent_userはnilを返す
     #!!(not)(not)によって，インスタンスが返ってきても真偽値に変換できる
     !!current_user
  end
end

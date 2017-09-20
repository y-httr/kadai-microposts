class SessionsController < ApplicationController
  def new
  end
  
  def create
    #mysession[:user_id]にログインユーザのIDが代入された時点でログイン完了    
    #ブラウザのクッキーにもログイン情報が保存される
    email = params[:mysession][:email].downcase    
    password = params[:mysession][:password]
    if login(email,password)
      flash[:success] = "ログインに成功しました"
      redirect_to @user
    else
      flash.now[:danger] = "ログインに失敗しました"
      render 'new'
    end
  end
  
  def destroy
    #ログインで保存したsession[:user_id]=@user.idを削除する(nilを代入)
    session[:user_id] = nil
    flash[:success] = "ログアウトしました．"
    redirect_to root_url
  end
  
  private
  def login(email, password)
    @user=User.find_by(email: email)
    if @user && @user.authenticate(password)
      #ログイン成功
      #以下のsessionはparams[:mysession]とは違うもの
      #サーバとブラウザにそれぞれ情報を保存する
      session[:user_id] = @user.id
      return true
    else
      #ログイン失敗
      return false
    end
  end
  
end

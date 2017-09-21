class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  #ControllerからデフォルトでHelperを呼ぶことはできないのでinclude
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    #unlessはfalseの時に処理を行う
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_microposts = user.microposts.count
  end
end

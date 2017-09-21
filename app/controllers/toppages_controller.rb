class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @micropost = current_user.microposts.build #form_for用(Micropost.new(user: current_user)と同じ)
      @microposts = current_user.microposts.order("created_at DESC").page(params[:page])
    end
  end
end

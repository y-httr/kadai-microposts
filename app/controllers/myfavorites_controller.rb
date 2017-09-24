class MyfavoritesController < ApplicationController
  before_action :require_user_logged_in
  def index
    @user = current_user
    @microposts = @user.favorites_microposts.order("created_at DESC").page(params[:page])
  end
end

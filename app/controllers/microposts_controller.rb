class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      #投稿に失敗した場合保存はされないが,@micropostsインスタンスには入ってしまうので取得し直す
      @microposts = current_user.microposts.order('created_at DESC').page(params[:page])
      
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success]="削除に成功しました"
    redirect_back(fallback_location: root_path) 
    #redirect_backはアクションが実行されたページへ戻るメソッド
    #fallback_location: root_pathは保険.戻る場所がない時に戻る場所
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url  
    end
  end
  
    
end

class RelationshipsController < ApplicationController
  def create
    #おそらく，ボタンでuserを選択するとform_forでそのuserのidをfollow_idに渡している？
    user=User.find(params[:follow_id])#フォローしたい人のインスタンス
    current_user.follow(user)
    flash[:success]="ユーザをフォローしました"
    redirect_to user #フォローした人のページへ
  end

  def destroy
    user=User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success]="ユーザのフォローを解除しました"
    redirect_to user #フォローを解除した人のページへ
  end
end

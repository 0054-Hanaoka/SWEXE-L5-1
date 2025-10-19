class LikesController < ApplicationController
    def index
        # ログイン中ユーザーのいいね一覧を取得
        user = User.find_by(uid: session[:login_uid])
        @liked_tweets = user.like_tweets.includes(:user)
    end

  def create
    tweet = Tweet.find(params[:tweet_id])
    user = User.find_by(uid: session[:login_uid])
    user.like_tweets << tweet
    redirect_to root_path
  end

  def destroy
    tweet = Tweet.find(params[:id])
    user = User.find_by(uid: session[:login_uid])
    like = tweet.likes.find_by(user_id: user.id)

    if like
      like.destroy
      flash[:notice] = "いいねを解除しました"
    else
      flash[:alert] = "いいねが存在しません"
    end

    redirect_to root_path
  end
  
  before_action :check_login

  private
  
  def check_login
    unless session[:login_uid]
      redirect_to top_main_path, alert: "ログインしてください"
    end
  end

end

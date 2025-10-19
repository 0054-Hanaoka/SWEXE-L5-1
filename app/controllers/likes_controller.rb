class LikesController < ApplicationController
  before_action :check_login

  def index
    # ログイン中ユーザーのいいね一覧
    user = current_user
    @liked_tweets = user.like_tweets.includes(:user)
  end

  def create
    user = current_user
    tweet = Tweet.find(params[:tweet_id])
    unless user.like_tweets.include?(tweet)
      user.like_tweets << tweet
    end
    redirect_to root_path, notice: "いいねしました"
  end

  def destroy
    user = current_user
    tweet = Tweet.find(params[:tweet_id])
    like = tweet.likes.find_by(user_id: user.id)
    if like
      like.destroy
      flash[:notice] = "いいねを解除しました"
    else
      flash[:alert] = "いいねが存在しません"
    end
    redirect_to root_path
  end

  private

  def check_login
    unless session[:login_uid]
      redirect_to top_main_path, alert: "ログインしてください"
    end
  end

  # よく使うのでメソッド化
  def current_user
    User.find_by(uid: session[:login_uid])
  end
end

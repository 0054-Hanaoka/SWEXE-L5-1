class LikesController < ApplicationController
  before_action :check_login

  def create
    tweet = Tweet.find(params[:tweet_id])
    user = User.find_by(uid: session[:login_uid])
    user.like_tweets << tweet unless user.like_tweets.exists?(tweet.id)
    redirect_to root_path
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
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

  private

  def check_login
    unless session[:login_uid]
      redirect_to top_main_path, alert: "ログインしてください"
    end
  end
end

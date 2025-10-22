class LikesController < ApplicationController
  before_action :check_login

  def create
    tweet = Tweet.find(params[:tweet_id])
    tweet.like(current_user) unless tweet.liked?(current_user)
    redirect_to root_path
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    tweet.unlike(current_user) if tweet.liked?(current_user)
    redirect_to root_path
  end

  private

  def check_login
    redirect_to top_main_path, alert: "ログインしてください" unless current_user
  end
end

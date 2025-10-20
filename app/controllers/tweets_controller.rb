class TweetsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_tweet, only: [:edit, :update, :destroy]

  def index
    @tweets = Tweet.all

    if session[:login_uid].present?
      @user = User.find_by(uid: session[:login_uid])
      @profile = @user&.profile
    end
  end
  
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)  # current_user を使う
    if @tweet.save
      redirect_to tweets_path, notice: "投稿しました"
    else
      puts @tweet.errors.full_messages
      render :new, status: 422
    end
  end

  def edit
    @user = @tweet.user
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to user_profile_path(@tweet.user), notice: "ツイートを更新しました"
    else
      render :edit, status: 422
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "ツイートを削除しました"
  end


  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:message)
  end
end

class TweetsController < ApplicationController
  # edit, update, destroy で共通して @tweet をセット
  before_action :set_tweet, only: [:edit, :update, :destroy]

  def index
    @tweets = Tweet.all
    if session[:login_uid]
      @user = User.find_by(uid: session[:login_uid])
      @profile = @user&.profile
    end
  end
  
  def new
    @tweet = Tweet.new
  end

  def create
    logged_in_user = User.find_by(uid: session[:login_uid])
    @tweet = Tweet.new(message: params[:tweet][:message], user: logged_in_user)

    if @tweet.save
      redirect_to tweets_path, notice: "投稿しました"
    else
      puts @tweet.errors.full_messages
      render :new, status: 422
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user  # ← これで @user が nil でなくなる
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


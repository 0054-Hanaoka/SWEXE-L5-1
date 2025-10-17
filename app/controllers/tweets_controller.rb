class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    # ログインしているユーザーを取得
    logged_in_user = User.find_by(uid: session[:login_uid])
  
    # Tweetに紐づけて作成
    @tweet = Tweet.new(message: params[:tweet][:message], user: logged_in_user)
  
    if @tweet.save
      redirect_to tweets_path, notice: "投稿しました"
    else
      puts "保存失敗の理由:"
      puts @tweet.errors.full_messages
      render :new, status: 422
    end
  end


  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to tweets_path, notice: "ツイートを削除しました"
  end
end

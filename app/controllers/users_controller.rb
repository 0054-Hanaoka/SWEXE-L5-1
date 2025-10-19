class UsersController < ApplicationController
  # new と create はログイン不要、それ以外はログイン必須
  before_action :require_login, except: [:new, :create]

  def index
    if session[:login_uid]
      @user = User.find_by(uid: session[:login_uid])
      @profile = @user.profile
    end
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    uid = params[:user][:uid]
    pass = params[:user][:pass]

    @user = User.new(uid: uid, pass: BCrypt::Password.create(pass))

    if @user.save
      session[:login_uid] = @user.uid  # 登録後に自動ログインさせる場合
      redirect_to users_path, notice: "ユーザーを作成しました"
    else
      render :new, status: 422
    end
  end

  def destroy
    u = User.find(params[:id])
    u.destroy
    redirect_to users_path, notice: "ユーザーを削除しました"
  end

  private

  def require_login
    unless session[:login_uid]
      redirect_to root_path, alert: "ログインしてください"
    end
  end
end

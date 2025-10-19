class UsersController < ApplicationController
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
  
  before_action :require_login

  def require_login
    unless session[:login_uid]
      redirect_to root_path, alert: "ログインしてください"
    end
  end
end

class UsersController < ApplicationController
  def index
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
end

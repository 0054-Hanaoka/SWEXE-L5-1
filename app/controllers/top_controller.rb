class TopController < ApplicationController
  def main
    if session[:login_uid]
      @user = User.find_by(uid: session[:login_uid])
      @profile = @user.profile  # ← プロフィール情報を取得
      render "main"
    else
      render "login"
    end
  end

  def login
    uid = params[:uid]
    pass = params[:pass]

    user = User.find_by(uid: uid)

    if user && BCrypt::Password.new(user.pass) == pass
      session[:login_uid] = uid
      redirect_to top_main_path  # ← プロフィール取得後の main にリダイレクト
    else
      render "error", status: 422
    end
  end

  def logout
    session.delete(:login_uid)
    redirect_to top_main_path
  end
end


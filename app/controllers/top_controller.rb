class TopController < ApplicationController
  def login
    uid = params[:uid]
    pass = params[:pass]
  
    user = User.find_by(uid: uid)
    if user && BCrypt::Password.new(user.pass) == pass
      session[:login_uid] = user.uid
      redirect_to top_main_path
    else
      flash.now[:alert] = "IDまたはパスワードが違います"
      render "login", status: 422
    end
  end
  
  def main
    if session[:login_uid]
      @user = User.find_by(uid: session[:login_uid])
      if @user
        @profile = @user.profile
        render "main"
      else
        session.delete(:login_uid)
        redirect_to top_main_path, alert: "ユーザー情報が見つかりません"
      end
    else
      render "login"
    end
  end


  def logout
    session.delete(:login_uid)
    redirect_to top_main_path
  end
end


class TopController < ApplicationController
  def login
    user = User.find_by(uid: params[:uid])
  
    if user && user.authenticate(params[:pass])
      session[:login_uid] = user.uid
      redirect_to top_main_path
    else
      flash.now[:alert] = "IDまたはパスワードが違います"
      render "login", status: 422
    end
  end

  def main
    if current_user
      @profile = current_user.profile
      render "main"
    else
      render "login"
    end
  end



  def logout
    session.delete(:login_uid)
    redirect_to top_main_path
  end
end


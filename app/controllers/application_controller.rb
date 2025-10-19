class ApplicationController < ActionController::Base
  allow_browser versions: :modern


  def L4
    session[:c] ||= 0
    session[:c] = session[:c].to_i + 1
    render plain: session[:c]
  end
  
  helper_method :current_user  # ビューでも使えるようにする

  def current_user
    @current_user ||= User.find_by(uid: session[:login_uid]) if session[:login_uid]
  end

  def require_login
    redirect_to root_path, alert: "ログインしてください" unless current_user
  end
end

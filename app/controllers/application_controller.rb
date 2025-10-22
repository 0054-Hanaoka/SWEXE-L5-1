class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  # ビューでも current_user を使えるようにする
  helper_method :current_user

  # セッションカウントの例
  def L4
    session[:c] ||= 0
    session[:c] = session[:c].to_i + 1
    render plain: session[:c]
  end

  private

  # ログイン中のユーザーを返す
  def current_user
    @current_user ||= User.find_by(uid: session[:login_uid]) if session[:login_uid]
  end

  # ログイン必須チェック
  def require_login
    redirect_to root_path, alert: "ログインしてください" unless current_user
  end
end


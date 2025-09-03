module SessionsHelper
  # ユーザーをログインさせる
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーの情報を取ってくる！ (ログインしている場合！！)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # ユーザーをログアウトさせる
  def log_out
    reset_session
    @current_user = nil   # 安全のため
  end
end

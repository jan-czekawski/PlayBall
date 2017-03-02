class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to users_path
    end
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only perform that action for your own account"
      redirect_to users_path
    end
  end

  def require_same_user_for_courts
    if current_user.id != @court.user_id && !current_user.admin?
      flash[:danger] = "You can only perform that action for your own courts"
      redirect_to courts_path
    end
  end

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Only Admins can perform that action"
      redirect_to users_path
    end
  end
end

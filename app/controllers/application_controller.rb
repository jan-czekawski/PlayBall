class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  WillPaginate.per_page = 15


  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only perform that action for your own account"
      redirect_to @user
    end
  end

  def require_same_user_for_courts
    if current_user.id != @court.user_id && !current_user.admin?
      flash[:danger] = "You can only perform that action for your own courts"
      redirect_to @court
    end
  end

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Only Admins can perform that action"
      redirect_to users_path
    end
  end

end

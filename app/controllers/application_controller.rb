class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  WillPaginate.per_page = 15

  def require_user
    return if logged_in?
    flash[:danger] = "You must be logged in to perform that action"
    redirect_to login_path
  end

  # TODO: refactor require methods
  def require_same_user
    return if current_user == @user || current_user.admin?
    flash[:danger] = "You can only perform that action for your own account"
    redirect_to @user
  end

  def require_same_user_for_courts
    return if current_user.id == @court.user_id || current_user.admin?
    flash[:danger] = "You can only perform that action for your own courts"
    redirect_to @court
  end

  def require_same_user_for_comments
    return if current_user.id == @comment.user_id || current_user.admin?
    flash[:danger] = "You can only perform that action for your own comments"
    redirect_to court_path(params[:court_id])
  end

  def require_admin
    return if current_user.admin?
    flash[:danger] = "Only admins can perform that action"
    redirect_to users_path
  end
end

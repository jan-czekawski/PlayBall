class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # session[:user_id] = user.id
      # params[:session][:remember] == "1" ? remember(user) : forget(user)
      # flash[:success] = "You have successfully logged in"
      # friendly_redirect_or(user)
      if user.activated?
        session[:user_id] = user.id
        params[:session][:remember] == "1" ? remember(user) : forget(user)
        flash[:success] = "You have successfully logged in"
        friendly_redirect_or(user)
      else
        flash[:info] = "Your account wasn't activated."\
                       " Please check your email and activate your account."
        redirect_to courts_path
      end
    else
      flash.now[:danger] = "Incorrect login and/or password"
      render "new"
    end
  end

  def destroy
    if logged_in?
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
      flash[:info] = "You have successfully logged out"
    else
      flash[:danger] = "You weren't logged in"
    end
    redirect_to courts_path
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to courts_path
    else
      flash[:danger] = "There was something wrong with your login information"
      redirect_to courts_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "You have successfully logged out"
    redirect_to courts_path
  end

end
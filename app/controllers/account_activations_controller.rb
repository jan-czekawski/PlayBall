class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && user.authenticated?("activation", params[:id]) && !user.activated?
      user.update_columns(:activated => true, :activated_at => Time.zone.now)
      flash[:success] = "Your account's just been activated! You can log in now."
      redirect_to courts_path
    else
      flash[:danger] = "Your activation was not successfull. Link was not valid."
      redirect_to courts_path
    end
  end
end

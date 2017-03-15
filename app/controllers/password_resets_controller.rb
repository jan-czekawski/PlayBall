class PasswordResetsController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :correct_user?, only: [:edit, :update]
  before_action :not_expired?, only: [:edit, :update]


  def new
  end

  def create
    @user = User.find_by(:email => params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      UserMailer.password_reset(@user).deliver_now
      flash[:info] = "Message with reset password link was sent to your email address."
      redirect_to courts_path
    elsif params[:password_reset][:email].empty?
      flash.now[:danger] = "Email address cannot be empty."
      render 'new'
    elsif @user.nil?
      flash.now[:danger] = "That email address does not exist in our database."
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      flash.now[:danger] = "Password cannot be empty."
      render 'edit'
    elsif @user.update_attributes(user_params)
      flash[:success] = "Your password was changed."
      @user.update_attribute(:reset_digest, nil)
      redirect_to login_path
    else
      flash.now[:danger] = "There was an error. Please try again."
      render 'edit'
    end
  end

  private

    def set_user
      @user = User.find_by(:email => params[:email])
    end

    def not_expired?
      # unless self.reset_at > 2.hours.ago return false
      if @user.reset_at < 2.hours.ago 
        flash[:danger] = "Your password link has been expired."
        redirect_to new_password_reset_url
      end
    end


    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def correct_user?
      unless @user && @user.activated? && @user.authenticated?("reset", params[:id])
        flash[:danger] = "Invalid password reset link"
        redirect_to courts_path
      end
    end
end
class PasswordResetsController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :correct_user?, only: [:edit, :update]
  before_action :not_expired?, only: [:edit, :update]


  def new
  end

  def create
    @user = User.find_by(:email => params[:email])
    if @user
      @user.create_reset_digest
      UserMailer.password_reset(@user).deliver_now
      flash[:info] = "Message with reset password link was sent to your email address."
      redirect_to courts_path
    else
      flash[:danger] = "That email address does not exist in our database."
      redirect_to courts_path
    end
  end

  def edit
  end

  def update
    @user.update_attribute(:password_digest, User.digest(params[:password]))
    if @user.update
      flash[:success] = "Your password was changed."
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
      if self.reset_at < 2.hours.ago 
        flash[:danger] = "Your password link has been expired."
        redirect_to new_password_reset_url
      end
    end

    def correct_user?
      unless @user && @user.activated? && @user.authenticated?("reset", params[:id])
        flash[:danger] = "Invalid password reset link"
        redirect_to courts_path
      end
    end
end
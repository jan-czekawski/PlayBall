class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[index show edit update destroy]
  before_action :require_same_user, only: %i[edit update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    # TODO: use scope instead of "where"
    @courts = Court.paginate(page: params[:page]).where(user_id: @user.id)
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Activation link was sent to your email address"
      # session[:user_id] = @user.id
      # flash[:success] = 'User was successfully created.'
      redirect_to courts_path
    else
      render "new"
    end
  end

  def update
    if @user.update(user_params)
      flash[:info] = "User was successfully updated."
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    session[:user_id] = nil if current_user == @user
    @user.destroy
    flash[:danger] = "User was successfully destroyed."
    redirect_to users_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation, :picture)
  end
end

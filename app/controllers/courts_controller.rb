class CourtsController < ApplicationController
  before_action :set_court, only: [:show, :edit, :update, :destroy]
  before_action :created_by, only: [:show]
  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_same_user_for_courts, only: [:edit, :update, :destroy]

  def index
    @courts = Court.paginate(:page => params[:page])
  end

  def show
    @comment = @court.comments.build
    @comments = @court.comments.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @court = current_user.courts.build
  end

  def edit
  end

  def create
    @court = current_user.courts.build(court_params)
    if @court.save
      redirect_to courts_path
      flash[:success] = "Court was successfully added"
    else
      render "new"
    end
  end

  def update
    if @court.update(court_params)
      flash[:info] = "Court was successfully updated"
      redirect_to @court
    else
      render "edit"
    end
  end

  def destroy
    @court.destroy
    flash[:danger] = "Court was successfully deleted"
    redirect_to courts_path
  end

  private

    def set_court
      @court = Court.find(params[:id])
    end

    def court_params
      params.require(:court).permit(:name, :picture, :description, :latitude, :longitude)
    end

    def created_by
      @created = User.find(@court.user_id)
    end


end
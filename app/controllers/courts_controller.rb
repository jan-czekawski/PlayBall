class CourtsController < ApplicationController
  before_action :set_body_classes
  before_action :set_court, only: %i[show edit update destroy]
  before_action :require_user, only: %i[new create edit update destroy]
  before_action :require_same_user_for_courts, only: %i[edit update destroy]

  def index
    @flash_id = "home_page_flash"
    @courts = Court.paginate(page: params[:page])
  end

  def show
    @comment = @court.comments.build
    @comments = @court.comments.paginate(page: params[:page], per_page: 5)
  end

  def new
    @court = current_user.courts.build
  end

  def edit; end

  def create
    @court = current_user.courts.build(court_params)
    if @court.save
      flash[:success] = "Court was successfully added"
      redirect_to courts_path
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
    params.require(:court).permit(:name, :picture, :description,
                                  :latitude, :longitude)
  end

  def set_body_classes
    @body_classes = "body-courts"
  end
end

class CourtsController < ApplicationController
  before_action :set_court, only: [:show, :edit, :update, :destroy]
  before_action :created_by, only: [:show]
  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_same_user_for_courts, only: [:edit, :update, :destroy]

  #GET /courts
  def index
    @courts = Court.paginate(:page => params[:page])
  end

  #GET /courts/1
  def show
    @comment = @court.comments.build
    @comments = @court.comments.paginate(:page => params[:page], :per_page => 5)
  end

  #GET /courts/new
  def new
    @court = current_user.courts.build
  end

  #GET /courts/1/edit
  def edit
  end

  #POST /courts
  def create
    @court = current_user.courts.build(court_params)
    respond_to do |format|
      if @court.save
        format.html { redirect_to courts_path }
        flash[:success] = "Court was successfully added"
      else
        format.html { render :new }
      end
    end
  end

  #PATCH/PUT /courts/1
  def update
    respond_to do |format|
      if @court.update(court_params)
        flash[:info] = "Court was successfully updated"
        format.html { redirect_to @court }
      else
        format.html { render :edit }
      end
    end
  end

  #DELETE /courts/1
  def destroy
    @court.destroy
    flash[:danger] = "Court was successfully deleted"
    respond_to do |format|
      format.html { redirect_to courts_path }
    end
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
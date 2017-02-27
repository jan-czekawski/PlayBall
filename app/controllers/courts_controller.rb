class CourtsController < ApplicationController
  before_action :set_court, only: [:show, :edit, :update, :destroy]
  before_action :created_by, only: [:show]

  #GET /courts
  def index
    @courts = Court.all
  end

  #GET /courts/1
  def show

  end

  #GET /courts/new
  def new
    @court = Court.new
  end

  #GET /courts/1/edit
  def edit
  end

  #POST /courts
  def create
    @court = Court.new(court_params)
    @court.user = current_user

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
        format.html { redirect_to @court, notice: "Court was successfully updated"}
      else
        format.html { render :edit }
      end
    end
  end

  def upload
    uploaded_io = params[:court][:picture]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  #DELETE /courts/1
  def destroy
    @court.destroy
    respond_to do |format|
      format.html { redirect_to courts_url, notice: "Court was successfully deleted"}
    end
  end

  private

    def set_court
      @court = Court.find(params[:id])
    end

    def court_params
      params.require(:court).permit(:name, :picture, :description, :user_id)
    end

    def created_by
      @created = User.find(@court.user_id)
    end
end
class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def show
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user
    @comment.court_id = 3

    respond_to do |format|
      if @comment.save
        format.html { redirect_to courts_path }
        flash[:success] = "Comment was successfully added"
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash[:info] = "Comment was successfully updated"
        format.html { redirect_to courts_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @comment.destroy
    flash[:danger] = "Comment was successfully deleted"
    respond_to do |format|
      format.html { redirect_to courts_url }
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :court_id, :user_id)
    end
end
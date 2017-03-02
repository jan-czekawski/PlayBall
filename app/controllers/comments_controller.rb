class CommentsController < ApplicationController
  before_action :logged_in?, only: [:create, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    # byebug
    @comment = Court.find(params[:court_id]).comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to court_path(params[:court_id])
    else
      flash[:danger] = "Nope"
      redirect_to court_path(params[:court_id])
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
      format.html { redirect_to court_path(@comment.court_id) }
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
class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_entity, only: [:create]
  before_action :set_question

  def create
    @comment = @entity.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @question, notice: "Comment submitted successfully"
    else
      flash[:error] = "error while creating comment"
      render "questions/show", status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    redirect_to @question, notice: "Comment Deleted successfully"
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :body, :commentable_id, :commentable_type)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_entity
    @entity = comment_params[:commentable_type].constantize.find(comment_params[:commentable_id])
  end
  
  def set_question
    @question = Question.find_by(permalink: params[:question_permalink])
  end
end

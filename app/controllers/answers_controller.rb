class AnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer, only: [:edit, :destroy]

  def new
    @answer = @question.answers.build
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    if @answer.save
      redirect_to @question, notice: t("answer_publish_success")
    else
      flash[:error] = t("answer_publish_error")
      render "questions/show", status: :unprocessable_entity
    end
  end

  def destroy
    if @answer.destroy
      redirect_to @question, notice: t("answer_delete_success")
    else
      flash[:error] = t("answer_delete_error")
      render "questions/show", status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:user_id, :answer_body, :question_published_token)
  end

  def set_question
    @question = Question.find_by(published_token: params[:question_published_token])
  end

  def set_answer
    @answer = Answer.find_by(params[:id])
  end
end

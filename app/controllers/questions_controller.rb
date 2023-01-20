class QuestionsController < ApplicationController
  before_action :set_question, only: [:edit, :update, :destroy, :show]

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.build(question_params)
    respond_to do |format|
      if @question.publish_question(params[:publish])
        if params[:draft]
          format.html { redirect_to question_url(@question), notice: "Question drafted successfully" }
        else
          format.html { redirect_to question_url(@question), notice: "Question Published successfully" }
        end
        format.json { render :show, status: :created, location: @question }
      else
        flash[:error] = "Ooooppss, something went wrong!"
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @question.update_question(question_params, params[:publish])
      if params[:draft]
        redirect_to question_path, notice: t("Question drafted successfully")
      else
        redirect_to question_path, notice: t("Question updated successfully")
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @question.destroy
      redirect_to user_path, notice: t("Question deleted successfully")
    else
      render :show, status: :unprocessable_entity
    end
  end

  def show
  end

  def index
    @questions = @q.result
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :pdf_attachment, :published_token, topic_list: [])
  end

  def set_question
    @question = Question.find_by(published_token: params[:published_token])
  end
end

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_global_search_variable
  before_action :authorize_user

  def search
    index
    render :index
  end

  private

  def authorize_user
    unless logged_in?
      redirect_to login_url,notice: t("login_prompt")
    end
  end

  def set_global_search_variable
    @q = Question.published_questions.ransack(params[:q])
  end
end

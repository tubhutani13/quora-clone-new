class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_global_search_variable

  def search
    index
    render :index
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def set_global_search_variable
    @q = Question.ransack(params[:q]&.merge(published_true: 1))
  end
end

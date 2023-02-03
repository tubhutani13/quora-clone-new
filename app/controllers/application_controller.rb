class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def authorize_user
    unless logged_in?
      store_location
      flash[:danger] = t("login_prompt")
      redirect_to login_url
    end
  end
end

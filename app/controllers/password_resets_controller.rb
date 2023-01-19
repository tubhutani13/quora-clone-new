class PasswordResetsController < ApplicationController
  before_action :set_user_by_password_reset_token, only: [:edit, :update]
  before_action :set_user_by_email, only: [:create]

  def new
  end

  def create
    if @user
      @user.send_password_reset
      flash[:notice] = t("E-mail sent with password reset instructions.")
      redirect_to new_session_path
    else
      flash[:error] = "Invalid email address"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.password_reset_sent_at < 2.hour.ago
      flash[:notice] = t("Password reset has expired")
      redirect_to new_password_reset_path
    elsif @user.update(user_params)
      flash[:notice] = t("Password has been reset!")
      redirect_to new_session_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end

  def set_user_by_password_reset_token
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def set_user_by_email
    @user = User.find_by_email(params[:email])
  end
end

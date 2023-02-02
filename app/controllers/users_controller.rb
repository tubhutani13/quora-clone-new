class UsersController < ApplicationController
  before_action :authorize_user, only: [:show]
  before_action :set_user, only: [:show]
  before_action :set_user_by_email_confirm_token, only: [:confirm_email]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user.id).deliver
      flash[:success] = t("confirm_email")
      redirect_to root_url
    else
      flash[:error] = "Ooooppss, something went wrong!"
      render :new, status: :unprocessable_entity
    end
  end

  def confirm_email
    if @user.email_activate
      flash[:success] = t("email_activated")
      redirect_to login_url
    else
      flash[:error] = "Ooooppss, something went wrong!"
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_by_email_confirm_token
    @user = User.find_by_email_confirm_token(params[:id])
    unless @user
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end
end

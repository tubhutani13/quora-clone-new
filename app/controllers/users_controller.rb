class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :set_user, only: [:show,:edit,:update]
  before_action :set_user_by_email_confirm_token, only: [:confirm_email]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user.id).deliver
      flash[:success] = "Please confirm your email address to continue"
      redirect_to root_url
    else
      flash[:error] = "Ooooppss, something went wrong!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: t("profile_update_success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def confirm_email
    if @user
      @user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:profile_picture, topic_list: [])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_by_email_confirm_token
    @user = User.find_by_email_confirm_token(params[:id])
  end
end

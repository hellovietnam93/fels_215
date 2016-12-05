class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.signup"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.update"
      redirect_to @user
    else
      flash[:danger] = t "flash.error"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "flash.error"
      redirect_to root_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end
end

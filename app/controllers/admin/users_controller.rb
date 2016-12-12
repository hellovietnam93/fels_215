class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_user, only: :destroy

  def index
    @users = User.search_users(params[:search]).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    unless @user.destroy
      flash.now[:danger] = t "user_delete_error"
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "user_not_found"
      redirect_to admin_users_path
    end
  end
end

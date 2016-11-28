class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "not_admin"
      redirect_to root_path
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger]= t "please_login"
      redirect_to login_path
    end
  end
end

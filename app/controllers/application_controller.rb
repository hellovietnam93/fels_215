class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include LessonsHelper

  private
  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "controllers.not_admin"
      redirect_to root_path
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "controllers.please_login"
      redirect_to login_url
    end
  end
end

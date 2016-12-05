class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :find_category, only: :show

  def index
    @categories = Category.search(params[:search]).sort
  end

  def show
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "controllers.admin.category_not_found"
      redirect_to root_path
    end
  end
end

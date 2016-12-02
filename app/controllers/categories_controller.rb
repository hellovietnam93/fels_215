class CategoriesController < ApplicationController
  def index
    @categories = Category.search(params[:search]).sort
  end

  def show
  end
end

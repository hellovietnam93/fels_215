class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_category, only: [:update, :edit, :destroy]
  before_action :load_categories, only: [:edit, :update, :new]

  def index
    @categories = Category.search(params[:search]).paginate page:
      params[:page], per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      respond_to do |format|
        format.js
      end
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_success"
      redirect_to new_admin_category_path
    else
      render :edit
    end
  end

  def destroy

  end

  private
  def category_params
    params.require(:category).permit :name, :duration, :num_ques_per_lesson
  end

  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "category_not_found"
      redirect_to home_path
    end
  end

  def load_categories
    @categories = Category.sort.paginate page: params[:page],
      per_page: Settings.per_page
  end
end

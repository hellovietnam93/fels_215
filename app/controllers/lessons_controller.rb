class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :find_category, only: [:index, :create]
  include CategoryUtils

  def index
    @lesson = Lesson.new
    @lessons = current_user.lessons.where(@lesson.category_id).order_desc
  end

  def create
    @lesson = current_user.lessons.build category: @category
    if @lesson.save
      respond_to do |format|
        format.js
      end
    else
      render :new
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :user_id, :category_id
  end

  def find_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "controllers.admin.category_not_found"
      redirect_to root_path
    end
  end

end

class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :find_category, only: [:index, :create]
  before_action :find_lesson, only: [:show, :update]

  include CategoryUtils

  def index
    @lesson = Lesson.new
    @lessons = current_user.lessons.where(@lesson.category_id).order_desc
  end

  def show
    @lesson.start_lesson if @lesson.init?
    @results = @lesson.results
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

  def update
    if @lesson.finished?
      flash[:danger] = t "controllers.lessons.lesson_finished_error_message"
    else
      @lesson.assign_attributes lesson_params
      save_fields
    end
    redirect_to category_lessons_path(@lesson.category_id)
  end

  private
  def lesson_params
    params.require(:lesson).permit :user_id, :category_id,
      results_attributes: [:answer_id, :id]
  end

  def find_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "controllers.admin.category_not_found"
      redirect_to root_path
    end
  end

  def find_lesson
    @lesson = Lesson.find_by id: params[:id]
    if @lesson.nil?
      flash[:danger] = t "controllers.lessons.lesson_not_found_message"
      redirect_to request.referrer || root_url
    end
  end

end

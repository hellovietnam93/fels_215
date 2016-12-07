class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_words
  before_action :find_word, except: [:index, :create, :new]
  include CategoryUtils

  def index
  end

  def new
    @word = Word.new
      Settings.answers_num_default.times{@word.answers.build}
  end

  def create
    @word = Word.new word_params
    @word.save
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "controllers.admin.update_success"
      redirect_to new_admin_word_path
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:content, :is_correct, :_destroy, :id]
  end

  def load_words
    @words = Word.sort.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def find_word
    @word = Word.find_by id: params[:id]
    if @word.nil?
      flash[:danger] = t "flash.error"
      redirect_to new_admin_word_path
    end
  end
end

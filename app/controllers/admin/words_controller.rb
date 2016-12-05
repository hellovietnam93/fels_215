class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_words
  include CategoryUtils

  def index
  end

  def new
    @word = Word.new
      Settings.answers_num_default.times{@word.answers.build}
  end

  def create
    @word = Word.new word_params
    if @word.save
      respond_to do |format|
        format.js
      end
    else
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:content, :is_correct]
  end

  def load_words
    @words = Word.sort.paginate page: params[:page],
      per_page: Settings.per_page
  end
end

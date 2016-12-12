class WordsController < ApplicationController
  before_action :logged_in_user, only: :index

  include CategoryUtils

  def index
    @words = if params[:option].present?
      Word.filter_by_category(params[:category_id])
        .send(params[:option], current_user)
    else
      Word.all
    end.order_by_content
    respond_to do |format|
      format.html
      format.js
    end
  end
end

class WordsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @words = Word.search(params[:search]).order_by_content
      .paginate page: params[:page], per_page: Settings.per_page
  end
end

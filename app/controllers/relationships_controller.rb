class RelationshipsController < ApplicationController
  include UserConcerns
  before_action :logged_in_user
  before_action :find_user, only: :index

  def index
    @title = params[:title].capitalize
    @users = @user.send(params[:title]).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    @user = User.find_by id: params[:followed_id]
    if @user.nil?
      flash[:danger] = t "flash.error"
      redirect_to root_url
    else
      current_user.follow @user
      @relationship = current_user.active_relationships
        .find_by followed_id: @user.id
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    @relationship = current_user.active_relationships.build
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end

module UserConcerns
  extend ActiveSupport::Concern

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "flash.error"
      redirect_to root_url
    end
  end
end

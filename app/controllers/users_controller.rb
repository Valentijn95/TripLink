class UsersController < ApplicationController
  def index
    @users = User.all
    @guides = User.where(guide: true)
  end

  def show
    @guide = User.find(params[:id])
    @interests = @guide.interests.pluck(:interest)
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end
end

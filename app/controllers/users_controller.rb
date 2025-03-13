class UsersController < ApplicationController
  def index
    @users = User.all
    @guides = User.where(guide: true)
  end

  def show
    @user = User.find(params[:id])
    @interests = @user.interests.pluck(:interest)
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end
end

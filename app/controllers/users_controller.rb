class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @guides = User.where(guide: true)
  end

  def show
    @user = User.find(params[:id])
    @interests = @user.interests.pluck(:interest)
    @match = Match.new
  end


  private

  def user_params
    params.require(:user).permit(:photo)
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @guides = User.where(guide: true)
  end

  def show
    @this_match = Match.where(tourist_id: current_user.id, guide_id: params[:id])
    @guide = User.find(params[:id])
    @guide_interests = @guide.interests.pluck(:interest)
    @user = current_user
    @user_interests = @user.interests.pluck(:interest)
    @match = Match.new
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end
end

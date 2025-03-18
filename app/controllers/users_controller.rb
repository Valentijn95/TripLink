

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

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


  def edit
    @interests = Interest.all
    @user_interest_ids = @user.interests.pluck(:id) 
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:photo, interest_ids: [])
  end
end

class UsersController < ApplicationController

  def index
    @users = User.all
    @user = User.first
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end
end

class MatchesController < ApplicationController
  before_action :set_match, only: [:show]


  def index
    @user = current_user
    @matches_as_tourist = Match.where(tourist_id: @user)
    @matches_as_guide = Match.where(guide_id: @user)
  end



  def show
    if current_user == @match.guide
      @matched_user = @match.tourist
    else
      @matched_user = @match.guide
    end
    @message = Message.new
  end


  def create
    @match = Match.new
    @match.tourist = current_user
    @match.guide = User.find(params[:user_id])
    @match.location = Location.find(params[:match][:location_id])
    @match.status = "pending"
    if @match.save
      redirect_to matches_path
    else
      render "users/#{params[:user_id]}?location=#{params[:match][:location_id]}"
    end
  end


  def new
    @guide = User.find(params[:guide_id])
    @match = Match.new
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:guide_id, :location_id)
  end

end

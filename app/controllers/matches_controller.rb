class MatchesController < ApplicationController
  before_action :set_match, only: [:show]

  def index
    @user = current_user
    @matches = Match.where(tourist_id: @user)
  end

  def show
    if current_user == @match.guide
      @matched_user = @match.tourist
    else
      @matched_user = @match.guide
    end
    @match = Match.find(params[:id])
    @message = Message.new
  end

  def create
    @match = Match.new
    @match.tourist = current_user
    @match.guide = User.find(params[:user_id])
    @match.location = @match.guide.locations.first
    raise
  end


  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:guide_id)
  end

end

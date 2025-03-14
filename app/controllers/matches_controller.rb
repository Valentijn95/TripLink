class MatchesController < ApplicationController
  before_action :set_match, only: [:show]

  def show
    if current_user == @match.guide
      @matched_user = @match.tourist
    else
      @matched_user = @match.guide
    end
    @message = Message.new
  end

  def new
    @guide = User.find(params[:guide_id])
    @match = Match.new
  end

  def create
    raise
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end
end

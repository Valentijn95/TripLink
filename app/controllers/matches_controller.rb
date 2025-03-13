class MatchesController < ApplicationController
  before_action :set_match, only: [:show]


  def show
    if current_user == @match.guide
      @matched_user = @match.tourist
    else
      @matched_user = @match.guide
    end
    @match = Match.find(params[:id])
    @message = Message.new
  end


  private

  def set_match
    @match = Match.find(params[:id])
  end
end

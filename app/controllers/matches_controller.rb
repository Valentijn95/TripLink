class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :send_message]

  def show
  end

  def send_message
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end
end

class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :chat]

  def show
  end

  def chat
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end
end


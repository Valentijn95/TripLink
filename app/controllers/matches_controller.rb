class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :chat, :send_message]

  def show
    # You can test if @match is set correctly
  end

  def chat
    # Chat-related logic
  end

  def send_message
    @message = @match.messages.build(content: params[:content], user: current_user)

    if @message.save
      redirect_to match_path(@match)
    else
      render :chat
    end
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end
end

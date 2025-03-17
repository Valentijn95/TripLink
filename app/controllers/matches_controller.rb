class MatchesController < ApplicationController
  before_action :set_guide, only: [:new]
  before_action :set_match, only: [:show, :create_message]

  def show
    @match = Match.find(params[:id])
    @message = Message.new
    @matched_user = @match.guide
  end

  def new
    @guide = User.find(params[:guide_id])
    @match = Match.find_or_create_by(guide_id: @guide.id, tourist_id: current_user.id)
    @message = Message.new
  end

  def create_message
    @match = Match.find(params[:match_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.match = @match

    if @message.save
      redirect_to match_path(@match), notice: 'Message sent successfully!'
    else
      render :new
    end
  end

  private

  def set_guide
    @guide = User.find(params[:guide_id])
  end

  def set_match
    @match = Match.find(params[:match_id] || params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end

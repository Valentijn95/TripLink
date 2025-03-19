class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_guide, only: [:new]
  before_action :set_match, only: [:show, :create_message]

  def index
    @user = current_user
    @matches_as_tourist = Match.where(tourist_id: @user)
    @matches_as_guide = Match.where(guide_id: @user)
  end

  def update
    @match = Match.find(params[:id])
    @match.status = params[:status]
    if @match.save
      @match.broadcast_tourist_match
      redirect_to matches_path
    else
      render :show
    end
  end

  def finish
    @match = Match.find(params[:id])
    @match.status = "pending-finished"
    if @match.save
      @match.broadcast_guide_notification(@match.tourist.name + " wants to finish the match")
      redirect_to matches_path, notice: "finish match request sent"
    else
      redirect_to matches_path, alert: "Failed to finish match"
    end
  end

  def end
    @match = Match.find(params[:id])
    if params[:value] == "yes"
      @match.status = "finished"
      if @match.save
        redirect_to matches_path, notice: "match finished"
      else
        redirect_to matches_path, alert: "failed to finish match"
      end
    elsif params[:value] == "no"
      @match.status = "accepted"
      if @match.save
        redirect_to matches_path, notice: "match resumed"
      else
        redirect_to matches_path, alert: "failed to finish match"
      end
    elsif params[:value] == "cancel"
      @match.status = "cancelled"
      if @match.save
        redirect_to matches_path, notice: "match cancelled"
      else
        redirect_to matches_path, alert: "failed to cancel match"
      end
    end
  end

  def show
    @match = Match.find(params[:id])
    @message = Message.new

    if current_user == @match.tourist
      @matched_user = @match.guide
    else
      @matched_user = @match.tourist
    end
  end

    def new
      @guide = User.find(params[:guide_id])
      @match = Match.new
    end

  def create
    if params[:match][:message] == ""
      flash[:alert] = "request failed: message can't be blank"
      render "users/#{params[:guide_id]}?location=#{params[:match][:location_id]}"
    else
      @match = Match.new
      @match.tourist = current_user
      @match.guide = User.find(params[:match][:guide_id])
      @match.location = Location.find(params[:match][:location_id])
      @match.status = "pending"


      if @match.save
        create_message(params[:match][:message], @match)
        @match.broadcast_guide_match
        redirect_to matches_path
      else
        render "users/#{params[:user_id]}?location=#{params[:match][:location_id]}"
      end
    end
  end

  def new
    @location = Location.find(params[:location_id])
    @match = Match.new
    @message = Message.new
  end

  def create_message(message, match)
    @message = Message.new(content: message)
    @message.user = current_user
    @message.match = match
    if @message.save
      flash[:notice] = "message sent to user"
    else
      flash[:notice] = "was not able to send message to user"
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

  def match_params
    params.require(:match).permit(:guide_id, :location_id)
  end

end

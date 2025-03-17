class MatchesController < ApplicationController
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
      redirect_to matches_path
    else
      render :show
    end
  end



  def show
    @match = Match.find(params[:id])
    @message = Message.new
    @matched_user = @match.guide
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

  def match_params
    params.require(:match).permit(:guide_id, :location_id)
  end

end

class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :send_message]


  def show
    @match = Match.find(params[:id])
    @message = @match.messages.new 
  end

  def send_message
    @message = @match.messages.new(message_params)
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            :messages,
            partial: "messages/message",
            target: "messages",
            locals: { message: @message }
          )
        end
        format.html { redirect_to @match, notice: "Message sent!" }
      end
    else
      render :show, status: :unprocessable_entity
    end
  end


  private

  def set_match
    @match = Match.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end

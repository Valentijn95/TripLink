class MessagesController < ApplicationController

  def create
    @match = Match.find(params[:match_id])
    @message = Message.new(message_params)
    @message.match = @match
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:messages, partial: "messages/message",
            target: "messages",
            locals: { message: @message, user: current_user })
        end
      end
    else
        render "matches/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end

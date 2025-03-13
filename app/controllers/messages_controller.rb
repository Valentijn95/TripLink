class MessagesController < ApplicationController

  def create
    @match = Match.find(params[:match_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.match = @match

    if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:messages, partial: "messages/message",
            target: "messages",
            locals: { message: @message })
        end
      end
    else
      render "matches/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end

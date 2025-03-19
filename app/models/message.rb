class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user

  validates :content, presence: true

  after_create_commit :broadcast_message

  def broadcast_message
    guide = match.guide
    tourist = match.tourist
    if user == guide
      receiver = tourist
    else
      receiver = guide
    end
    broadcast_append_to "chat-#{match.id}-#{receiver.id}",
                        partial: "messages/message",
                        target: "messages",
                        locals: { message: self, user: receiver }

  end
end

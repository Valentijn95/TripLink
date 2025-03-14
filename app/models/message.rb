class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user

  validates :content, presence: true

  after_create_commit :broadcast_message

  def broadcast_message
    broadcast_append_to match,
                        partial: "messages/message",
                        target: "messages",
                        locals: { message: self, user: user }
  end
end

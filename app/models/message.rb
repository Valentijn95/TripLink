class Message < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :content, presence: true

  after_create_commit :broadcast_message

  private

  def broadcast_message
    broadcast_append_to "match_#{self.match.id}_messages", target: "messages", partial: "messages/message", locals: { message: self, target: "messages" }
  end
end

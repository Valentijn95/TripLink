class Message < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :content, presence: true

  after_create_commit :broadcast_message

  private

  after_create_commit do
    broadcast_append_to "match_#{match.id}_messages", target: "messages", partial: "messages/message", locals: { message: self }
  end
end

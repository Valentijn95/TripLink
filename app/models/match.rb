class Match < ApplicationRecord
  belongs_to :guide, class_name: 'User', foreign_key: 'guide_id'
  belongs_to :tourist, class_name: 'User', foreign_key: 'tourist_id'

  belongs_to :location

  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validate :guide_is_valid
  validates :tourist, :location, :status, presence: true

  validates :status, inclusion: { in: %w(pending accepted declined) }

  after_create :broadcast_guide_notification
  # commented this line to prevent the function from being triggered immediately
  # after_create :broadcast_guide_match

  def broadcast_guide_match
      broadcast_prepend_to "incomming_matches-#{guide.id}",
                          partial: "matches/guide_match",
                          target: "incomming_matches",
                          locals: { match: self, incoming: "New incoming match" }

      broadcast_replace_to "incomming_matches-#{guide.id}",
                          partial: "matches/guide_match",
                          target: "match_#{id}",
                          locals: { match: self, incoming: "New incoming match" }
  end

  def broadcast_tourist_match
      broadcast_replace_to "incomming_matches-#{tourist.id}",
                          partial: "matches/tourist_match",
                          target: "match_#{id}",
                          locals: { match: self }
end

  def broadcast_guide_notification
    broadcast_replace_to "flashes-#{guide.id}",
                        partial: "shared/flashes",
                        target: "flashes",
                        locals: { notice: "You have a new match!", alert: false }

    broadcast_replace_to "header-#{guide.id}",
                        partial: "shared/header",
                        target: "header",
                        locals: { added_class: "active", user: guide }
  end

  private

  def guide_is_valid
    if guide.present? && !guide.guide?
      errors.add(:guide, "guide must be a user with guide set to true")
    end
  end
end

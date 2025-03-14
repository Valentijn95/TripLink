class Match < ApplicationRecord
  belongs_to :guide, class_name: 'User', foreign_key: 'guide_id'
  belongs_to :tourist, class_name: 'User', foreign_key: 'tourist_id'

  belongs_to :location

  has_many :messages
  has_many :reviews, dependent: :destroy

  validate :guide_is_valid
  validates :tourist, :location, :status, presence: true

  validates :status, inclusion: { in: %w(pending accepted declined) }

  private

  def guide_is_valid
    if guide.present? && !guide.guide?
      errors.add(:guide, "guide must be a user with guide set to true")
    end
  end
end

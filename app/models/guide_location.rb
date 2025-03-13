class GuideLocation < ApplicationRecord
  belongs_to :user
  belongs_to :location
  alias_attribute :guide, :user

  validates :location_id, presence: true
  validate :guide_is_valid

  validates :user_id, uniqueness: { scope: :location_id }



  private

  def guide_is_valid
    if guide.present? && !guide.guide?
      errors.add(:guide, "guide must be a user with guide set to true")
    end
  end
end

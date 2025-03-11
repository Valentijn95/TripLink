class GuideLocation < ApplicationRecord
  belongs_to :user
  belongs_to :location
  alias_attribute :guide, :user

  validate :guide_is_valid

  private

  def guide_is_valid
    if guide.present? && !guide.guide?
      errors.add(:guide, "guide must be a user with guide set to true")
    end
  end
end

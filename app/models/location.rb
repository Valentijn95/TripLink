class Location < ApplicationRecord
  has_many :guide_locations, dependent: :destroy
  has_many :users, through: :guide_locations
  alias_attribute :guides, :users

  has_many :matches, dependent: :destroy

  geocoded_by :address, :latitude  => :lat, :longitude => :lng
  after_validation :geocode, if: :will_save_change_to_address?

  validates :lat, :lng, presence: true
  validates :address, presence: true, uniqueness: true
end

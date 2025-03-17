class Location < ApplicationRecord
  has_many :guide_locations, dependent: :destroy
  has_many :users, through: :guide_locations
  alias_attribute :guides, :users

  has_many :matches, dependent: :destroy
  geocoded_by :address, :latitude => :lat, :longitude => :lng
  after_validation :geocode, if: :will_save_change_to_address?
  after_validation :set_city, if: :will_save_change_to_address?
  # after_validation :set_country, if: :will_save_change_to_address?

  # validates :lat, :lng, presence: true
  validates :address, presence: true
  # validates_uniqueness_of :address, message: "This location already exists in the database

  # def set_place
  #   results = Geocoder.search([self.lat, self.lng])
  #   results.first.data["context"]
  # end

  private

  def set_city
    results = Geocoder.search([self.lat, self.lng])
    self.city = results.first.city
  end

  # def set_country
  #   results = Geocoder.search([self.lat, self.lng])
  #   self.country = results.first.data["context"][5]["text"]
  # end

end

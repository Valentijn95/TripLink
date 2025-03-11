class Location < ApplicationRecord
  has_many :guide_locations
  has_many :users, through: :guide_locations
  alias_attribute :guides, :users
end

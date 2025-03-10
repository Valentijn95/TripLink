class Location < ApplicationRecord
  has_many :guides, through: :guide_locations, source: :users
end

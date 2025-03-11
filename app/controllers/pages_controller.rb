class PagesController < ApplicationController

  def home
    @default_locations = Location.joins(:guide_locations).distinct
    @markers = get_markers(@default_locations)
  end

  def get_markers(locations)
    markers = locations.geocoded.map do |location|
      {
        lat: location.lat,
        lng: location.lng
      }
    end
    return markers
  end

end

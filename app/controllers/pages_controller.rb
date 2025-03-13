class PagesController < ApplicationController

  def home
    @default_locations = Location.all
    @markers = get_markers(@default_locations)
  end

  def profile
    @user = current_user
  end

  def get_markers(locations)
    markers = locations.geocoded.map do |location|
      {
        lat: location.lat,
        lng: location.lng,
        location_id: location.id
      }
    end
    return markers
  end

end

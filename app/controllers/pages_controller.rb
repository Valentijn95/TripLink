class PagesController < ApplicationController

  def home
    @default_locations = Location.all
    @markers = get_markers(@default_locations)
  end

  def render_location_partial
    @location = Location.find(params[:id])
    @guides = User.where(id: params[:guide_ids])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "location-info",
          partial: "pages/location_information_window",
          locals: { location: @location, guides: @guides }
        )
      end
    end
  end

  def render_empty_location_partial
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "location-info",
          partial: "pages/location_information_window",
          locals: { location: nil, guides: nil }
        )
      end
    end
  end

  def get_markers(locations)

    markers = locations.geocoded.map do |location|
      guides = User.joins(:guide_locations).where("guide_locations.location_id = ?", location.id).map { |user| user.id }
      {
        lat: location.lat,
        lng: location.lng,
        marker_data: { location: location.id, guides: guides },
      }
    end
    return markers
  end

end

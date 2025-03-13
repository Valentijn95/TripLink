class PagesController < ApplicationController

  def home
    # if params[:location_search].present?
    #   @default_locations = Location.near(params[:location_search], 50)
    # end
    @default_locations = Location.near("Keukenhof, Lisse", 50)
    @markers = get_markers(@default_locations)
  end

  def home_search
    raise
    redirect_to root_path
  end

  def profile
    @user = current_user
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
      guides = User.joins(:guide_locations).where("guide_locations.location_id = ?", location.id)
      {
        lat: location.lat,
        lng: location.lng,
        marker_data: { location: location, guides: guides },
      }
    end
    return markers
  end

end

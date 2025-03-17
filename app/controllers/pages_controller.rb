class PagesController < ApplicationController

  def home
    if session[:markers].nil?
      # load locations that have a guide location
      @default_locations = Location.joins(:guide_locations).where("guide_locations.location_id = locations.id")
      @markers = get_markers(@default_locations)
    else
      @markers = session[:markers]
    end
    session.delete(:markers)
  end

  def home_search
    @default_locations = Location.joins(:guide_locations).where("guide_locations.location_id = locations.id").near(params[:location_search], 50)
    session[:markers] = get_markers(@default_locations)
    redirect_to root_path
  end

  def profile
    @user = current_user
  end

  def render_location_partial

    @location = Location.find(params[:id])
    guide_ids = params[:guide_ids].split(",").map { |id| id.to_i }
    @guides = User.where(id: guide_ids)

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

    # # find duplicate cities in all the different locations
    # array = []
    # locations.each do |location|
    #   array << location.city
    # end
    # cities = array.uniq()

    # # Geocode all the unique cities again
    # city_coordinates = {}
    # cities.each do |city|
    #   city_coordinates[city] = {
    #     lat: Geocoder.search(city).first.latitude,
    #     lng: Geocoder.search(city).first.longitude,
    #   }
    # end
    # city_coordinates
    # # raise


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

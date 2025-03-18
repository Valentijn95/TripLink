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
    # @all_locations = locations.map { |loc| loc }
    # duplicates = Location.group(:city).having("count(*) > 1").count
    # if duplicates.any?
    #   duplicates.each do |city|
    #     cities = Location.where(city: city)
    #     city_to_delete = cities.offset(1) # Keep the first instance and delete the rest
    #     city_to_delete.each do |c|
    #       @all_locations.delete(c)
    #     end
    #   end
    # end
    # @uniq = @all_locations.uniq()

    # Fetch all locations
    @all_locations = locations

    # Group locations by city and keep only the first instance of each city
    @uniq_locations = @all_locations.uniq { |loc| loc.city }

    markers = @uniq_locations.map do |location|
    # markers = locations.geocoded.map do |location|
      guides = User.joins(:guide_locations).where("guide_locations.location_id = ?", location.id).map { |user| user.id }
      {
        lat: location.city_lat,
        lng: location.city_lng,
        marker_data: { location: location.id, guides: guides },
      }
    end
    return markers
  end
end

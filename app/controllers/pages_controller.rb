class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

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
    @default_locations = Location.joins(:guide_locations).where("guide_locations.location_id = locations.id").near(params[:city], 50)
    session[:markers] = get_markers(@default_locations)
    redirect_to root_path
  end

  def profile
    @location = Location.new

    @user = current_user
    @user_interests = @user.interests
    @available_interests = Interest.all - @user_interests
  end

  def add_interest
    @user = current_user
    @interest = Interest.find(params[:interest_id])
    @user.interests << @interest
    redirect_to profile_path, notice: "Interest added"
  end

  def remove_interest
    @user = current_user
    @interest = Interest.find(params[:interest_id])
    @user.interests.destroy(@interest)
    redirect_to profile_path, notice: "Interest removed"
  end

  def new_guide
    @user = User.find(params[:id])
  end

  def apply_guide
    @user = User.find(params[:id])
    @user.guide_description = params[:user][:guide_description]
    @user.rate = params[:user][:rate]
    @user.guide = true
    if @user.save
      redirect_to profile_path, notice: "Contratulations you are now a guide!"
    else
      render :new_guide, status: :unprocessable_entity
    end
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
    # Group locations by city and keep only the first instance of each city
    @uniq_locations = locations.uniq { |loc| loc.city }

    markers = @uniq_locations.map do |unique_location|
    # markers = locations.geocoded.map do |location|
      guides = User.joins(:guide_locations, :locations)
                  .where("guide_locations.location_id = locations.id AND locations.city = ?", unique_location.city).map { |user| user.id }
      {
        lat: unique_location.city_lat,
        lng: unique_location.city_lng,
        marker_data: { location: unique_location.id, guides: guides },
      }
    end
    return markers
  end
end

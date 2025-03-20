class LocationsController < ApplicationController

  def create
    address = params[:location][:full_address]
    name = params[:location][:name]
    guide_location = GuideLocation.new

    location = Location.find_or_create_by(address: address) do |l|
      l.name = name
    end
    if location.save
      # make guide location
      guide_location.location = location
      guide_location.guide = current_user
      if guide_location.save
        redirect_to profile_path(current_user.id), notice: "Added location: #{location.name}"
      else
        redirect_to profile_path(current_user.id), alert: "Location could not be linked to your account"
      end
    else
      redirect_to profile_path(current_user.id), alert: "Location could not be created"
    end
  end

  def destroy
    location = Location.find(params[:id])
    if location.destroy
      redirect_to profile_path(current_user.id), notice: "Location deleted"
    else
      redirect_to profile_path(current_user.id), alert: "Location could not be deleted"
    end
  end
end

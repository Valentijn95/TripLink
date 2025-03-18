class ApiController < ApplicationController
  require 'net/http'

  def fetch_autocomplete_data
    query = params[:query]
    api_key = ENV["MAPBOX_API_KEY"]
    url = URI("https://api.mapbox.com/search/geocode/v6/forward?q=#{query}&proximity=ip&access_token=#{api_key}")

    response = Net::HTTP.get_response(url)

    render json: response.body, status: response.code.to_i
  end
end

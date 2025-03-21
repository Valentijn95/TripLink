class ApiController < ApplicationController
  require 'net/http'

  def fetch_autocomplete_data
    query = params[:query]
    api_key = ENV["MAPBOX_API_KEY"]
    # url = URI("https://api.mapbox.com/search/geocode/v6/forward?q=#{query}&proximity=ip&access_token=#{api_key}")
    url = URI("https://api.mapbox.com/search/searchbox/v1/suggest?q=#{query}&access_token=#{api_key}&session_token=4e882e35-9f28-46dd-b433-b9833aa78d03&language=en&limit=10&types=country%2Cregion%2Cplace%2Cneighborhood%2Caddress%2Cpoi%2Cstreet&proximity=-98%2C%2040")

    response = Net::HTTP.get_response(url)

    render json: response.body, status: response.code.to_i
  end
end

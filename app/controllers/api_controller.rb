class ApiController < ApplicationController
  require 'net/http'

  def fetch_autocomplete_data
    query = params[:query]
    api_key = ENV["MAPBOX_API_KEY"]
    # url = URI("https://api.mapbox.com/search/geocode/v6/forward?q=#{query}&proximity=ip&access_token=#{api_key}")
    url = URI("https://api.mapbox.com/search/searchbox/v1/suggest?q=#{query}&access_token=#{api_key}&session_token=3418cf89-5a67-42c3-8a2f-4b19ade37d32&language=en&limit=5&types=poi%2Caddress&proximity=-98%2C%2040")

    response = Net::HTTP.get_response(url)

    render json: response.body, status: response.code.to_i
  end
end

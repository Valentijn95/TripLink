# app/controllers/interests_controller.rb
class InterestsController < ApplicationController
  def search
    query = params[:query]
    # Searching only in the 'interest' attribute
    interests = Interest.joins(:users).where("interests.interest LIKE ?", "%#{query}%")


    render json: { interests: interests.map { |i| { id: i.id, interest: i.interest } } }
  end
end

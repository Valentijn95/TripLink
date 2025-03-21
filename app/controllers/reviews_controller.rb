class ReviewsController < ApplicationController
  before_action :set_match

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.match = @match
    @review.user = current_user
    if @review.save
      redirect_to user_path(@match.guide.id), notice: "Review created"
      @match.broadcast_guide_notification(@match.tourist.name + " wrote a review about you")
    else
      render :new, notice: "Something went wrong"
    end
  end

  private

  def set_match
    @match = Match.find(params[:match_id])
  end

  def review_params
    params.require(:review).permit(:content)
  end

end

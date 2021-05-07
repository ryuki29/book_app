class LikesController < ApplicationController
  before_action :set_review
  before_action :authenticate_user!

  def create
    if @review.user_id != current_user.id
      @like = Like.create(user_id: current_user.id, review_id: @review.id)
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, review_id: @review.id)
    @like.destroy
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end
end

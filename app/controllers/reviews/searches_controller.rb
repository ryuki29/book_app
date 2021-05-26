class Reviews::SearchesController < ApplicationController
  def index
    @reviews = Review.search(params[:keyword])
  end
end

class ReviewsController < ApplicationController

  def index
    @reviews = Review.all.order(id: "DESC")
  end

  def create
    @review = Review.new(review_params)
    @impressive_phrases = @review.impressive_phrases
    @action_plans = @review.action_plans

    @book = Book.new(book_params)

    status = user_book_params[:status].to_i

    user_book = UserBook.new(
      user: current_user,
      book: @book,
      status: status
    )

    return unless @book.save && user_book.save

    create_review if params[:review].present? # params[:review]が存在しているのか？

    @review.impressive_phrases = @impressive_phrases
    @review.action_plans = @action_plans

    redirect_to user_path(current_user.id) if @review.save
  end

  private

  def review_params
    params.require(:review).permit(
      :date,
      :text,
      :category,
      :rating,
      impressive_phrases_attributes: [:phrase, :_destroy, :id],
      action_plans_attributes: [:plan, :_destroy, :id]
    ).merge(
      user_id: current_user.id
    )
  end

  def book_params
    params.require(:book).permit(
      :title,
      :authors,
      :image_url,
      :uid
    )
  end

  def user_book_params
    params.require(:user_book).permit(:status)
  end

  def create_review
    @review = Review.create(
      user_id: current_user.id,
      book_id: @book.id,
      date: review_params[:date],
      text: review_params[:text],
      rating: review_params[:rating],
      category: review_params[:category]
    )
  end

end
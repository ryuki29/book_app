class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: %i[index search]
  before_action :set_review, only: %i[destroy show update]

  def index
    @reviews = Review.includes(:user, :book, :likes).recent.page(params[:page])
    @book_ranks = Book.book_ranks
    @board_ranks = Board.board_ranks
  end

  def create
    @book = Book.new(book_params)
    status = user_book_params[:status].to_i

    user_book = UserBook.new(
      user: current_user,
      book: @book,
      status: status
    )

    @review = Review.new(review_params)
    impressive_phrase = @review.impressive_phrase
    action_plan = @review.action_plan

    create_review

    if @review.save
      @book.save && user_book.save
      @review.impressive_phrase = impressive_phrase
      @review.action_plan = action_plan
      redirect_to user_path(current_user.id)
    end
  end

  def destroy
    redirect_to root_path if @review.destroy
  end

  def show
    @user = @review.user
    @comment = Comment.new
    @comments = @review.comments.includes(:user).asc
  end

  def update
    redirect_to request.referrer if @review.update(review_params)
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(
      :date,
      :tegline,
      :text,
      :category,
      :rating,
      impressive_phrase_attributes: %i[phrase _destroy id],
      action_plan_attributes: %i[plan deadline _destroy id]
    ).merge(
      user: current_user
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
      user: current_user,
      book: @book,
      date: review_params[:date],
      tegline: review_params[:tegline],
      text: review_params[:text],
      rating: review_params[:rating],
      category: review_params[:category]
    )
  end

end
class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: %i[index search]

  def index
    @reviews = Review.all.includes(:user, :book, :likes).order(created_at: :desc).page(params[:page]).per(10)

    uids = UserBook.joins(:book).where(status: 0).group(:uid).order('count_uid DESC').limit(3).count(:uid).keys
    @book_ranks = uids.map { |uid| Book.where(uid: uid) }

    @board_comment_ranks = Board.find(BoardComment.group(:board_id).order('count(board_id) desc').limit(5).pluck(:board_id))
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
    review = Review.find(params[:id])
    review.destroy
    redirect_to root_path
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @comment = Comment.new
    @comments = @review.comments.all.includes(:user).order(created_at: :asc)
  end

  private

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
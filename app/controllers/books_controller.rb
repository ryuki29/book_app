class BooksController < ApplicationController
  before_action :set_book, only: %i[show destroy]

  def create
    @book = Book.new(book_params)
    status = user_book_params[:status].to_i
    user_book = UserBook.new(
      user: current_user,
      book: @book,
      status: status
    )

    return unless @book.save && user_book.save

    render json: { "user_id": current_user.id, "book_status": status }
  end

  def show
    @bookCount = Book.where(uid: @book.uid).count
    review_list = Review.includes(:user, :book, :likes).recent.select_uid_book(@book)
    @review_list = Kaminari.paginate_array(review_list).page(params[:page]).per(10)
  end

  def destroy
    redirect_to request.referrer if @book.destroy
  end

  def search
    @books = []
    keyword = params[:keyword]

    return if keyword.empty?

    result = Book.search_books(keyword)
    @books = Book.set_search_result(result, @books)
    @review = Review.new
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :authors, :image_url, :uid)
  end

  def user_book_params
    params.require(:user_book).permit(:status)
  end
end

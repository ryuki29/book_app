class BooksController < ApplicationController

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
    @book = Book.find(params[:id])
    @bookCount = Book.where(uid: @book.uid).count

    @review_list = Review.all.order(created_at: :desc).select { |r|
      r.book.uid == @book.uid
    }
    @review_list = Kaminari.paginate_array(@review_list).page(params[:page]).per(10)
  end

  def search
    @books = []
    keyword = params[:keyword]

    return if params[:keyword].empty?

    result = Book.search_books(keyword)
    @books = Book.set_search_result(result, @books)
    @review = Review.new
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :authors, :image_url, :uid)
  end

  def user_book_params
    params.require(:user_book).permit(:status)
  end

end

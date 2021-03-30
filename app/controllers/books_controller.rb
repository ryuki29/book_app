class BooksController < ApplicationController

  def search
    @books = []
    @total_items = 0
    @keyword = params[:keyword]

    return if params[:keyword].empty?

    result = Book.search_books(@keyword)
    @books = Book.set_search_result(result, @books)
    @review = Review.new
  end

end

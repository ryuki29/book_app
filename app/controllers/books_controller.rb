class BooksController < ApplicationController
  def index
  end

  def show
  end

  def search
    @books = []
    @total_items = 0
    @keyword = params[:keyword]
    # @page = params[:page]

    return if params[:keyword].empty?

    result = Book.search_books(@keyword)

    @total_items = result['totalItems']

    return if @total_items.zero?

    @total_items = 100 if @total_items > 100
    @books = Book.set_search_result(result, @books)
  end
end

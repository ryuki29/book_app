class Boards::SearchesController < ApplicationController
  def index
    @boards = Board.search(params[:keyword])
    @board = Board.new
  end
end

class BoardsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_board, only: %i[show update destroy]

  def index
    @boards = Board.includes(:user).recent.page(params[:page])
    @board = Board.new
  end

  def show
    @user = @board.user
    @comments = @board.comments.includes(:user).recent.page(params[:page])
    @board_comment = BoardComment.new
  end

  def create
    board = Board.new(board_params)
    redirect_to boards_path if board.save
  end

  def update
    redirect_to request.referer if @board.update(board_params)
  end

  def destroy
    redirect_to boards_path if @board.destroy
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(
      :title,
      :board_type,
      :description,
      :image
    ).merge(
      user: current_user
    )
  end
end

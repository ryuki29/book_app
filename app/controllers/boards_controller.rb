class BoardsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
    @board = Board.new
  end

  def show
    @board = Board.find(params[:id])
    @user = @board.user
    @comments = @board.comments.all.includes(:user).order(created_at: :desc)
    @board_comment = BoardComment.new
  end

  def create
    board = Board.new(board_params)
    redirect_to boards_path if board.save
  end

  def update
    board = Board.find(params[:id])
    redirect_to request.referrer if board.update(board_params)
  end

  def destroy
    board = Board.find(params[:id])
    redirect_to boards_path if board.destroy
  end

  private

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

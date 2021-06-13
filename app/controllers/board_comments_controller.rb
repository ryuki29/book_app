class BoardCommentsController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    @board_comment = BoardComment.create(board_comment_params)
    if @board_comment.save
      board = @board_comment.board_id
      redirect_to request.referrer
    end
  end

  def destroy
    board_comment = BoardComment.find(params[:board_id])
    redirect_to request.referrer if board_comment.destroy
  end

  private

  def board_comment_params
    params.permit(:text, :image).merge(user_id: current_user.id, board_id: params[:board_id])
  end
end
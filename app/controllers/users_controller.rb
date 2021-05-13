class UsersController < ApplicationController
  before_action :find_user, only:[:show, :update]

  def show
    @books = user_book_status(0)
    @reading = user_book_status(1)
    @will_read = user_book_status(2)

    likes = Like.where(user_id: @user.id).ids
    @like_list = Like.find(likes)

    @review = Review.new
  end

  def update
    @user.update(user_params)
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :image, :profile)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_book_status(status)
    Book.joins(:user_books).where(user_books: {
                                  user_id: params[:id],
                                  status: status
                                  }).order(created_at: 'DESC')
  end
end

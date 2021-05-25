class UsersController < ApplicationController
  before_action :find_user, only: %i[show update following followers]

  def show
    @books = user_book_status(0)
    @reading = user_book_status(1)
    @will_read = user_book_status(2)

    likes = Like.where(user_id: @user.id).ids
    @like_list = Like.find(likes)

    @review = Review.new

    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom # まだルームが作られていなければ
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(current_user)
  end

  def following
    @title = 'Following'
    @users = @user.following
    render 'show_relationship'
  end

  def followers
    @title = 'Followers'
    @users = @user.followers
    render 'show_relationship'
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

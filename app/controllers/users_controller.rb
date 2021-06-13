class UsersController < ApplicationController
  before_action :find_user, only: %i[show update following followers]

  def index
    @users = User.all.search(params[:keyword]).page(params[:page]).per(10)
  end

  def show
    @books = user_book_status(0)
    @reading = user_book_status(1)
    @will_read = user_book_status(2)

    likes = Like.where(user_id: @user.id).ids
    like_list = Like.find(likes)
    @like_list = Kaminari.paginate_array(like_list).page(params[:page]).per(20)

    @review = Review.new

    if user_signed_in?
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
    review_categories = @user.reviews.group(:category).count
    @review_it         = review_categories["it"]
    @review_management = review_categories["management"]
    @review_economy    = review_categories["economy"]
    @review_finance    = review_categories["finance"]
    @review_thinking   = review_categories["thinking"]
    @review_motivation = review_categories["motivation"]
    @review_novel      = review_categories["novel"]
    @review_etc        = review_categories["etc"]
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
                                  }).order(created_at: 'DESC').page(params[:page]).per(20)
  end
end

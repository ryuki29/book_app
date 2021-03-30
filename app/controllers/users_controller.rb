class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @username = @user.username
    @reviews = Review.all
  end
end

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @username = @user.username
  end
end

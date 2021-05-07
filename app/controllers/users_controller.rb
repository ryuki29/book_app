class UsersController < ApplicationController
  before_action :find_user, only:[:show, :update]

  def show
    @status = params[:status] ? params[:status].to_i : 0

    likes = Like.where(user_id: @user.id).ids
    @like_list = Like.find(likes)
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
end

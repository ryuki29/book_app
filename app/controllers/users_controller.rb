class UsersController < ApplicationController
  def show
    @status = params[:status] ? params[:status].to_i : 0
    @user = User.find(params[:id])
  end
end

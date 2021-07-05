class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      @message.save
    else
      flash[:alert] = 'メッセージ送信に失敗しました。'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy if current_user.id == @message.user_id
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end
end

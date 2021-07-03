class BoardComment < ApplicationRecord
  belongs_to :user
  has_many :notifications, dependent: :destroy
  has_one_attached :image

  validates :text, presence: true, length: { maximum: 200 }

  def create_notification_comment(current_user, board_comment_id, board_id)
    temp_ids = BoardComment.select(:user_id).where(board_id: board_id).where.not(user_id: current_user.id).distinct

    temp_ids.each do |temp_id|
      save_notification_comment(current_user, temp_id['user_id'], board_comment_id, board_id)
    end

    visited_id = Board.find(board_id).user_id
    save_notification_comment(current_user, visited_id, board_comment_id, board_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, visited_id, board_comment_id, board_id)
    notification = current_user.active_notifications.new(
      visited_id: visited_id,
      board_id: board_id,
      board_comment_id: board_comment_id,
      action: 'board_comment'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end

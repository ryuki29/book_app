class AddColumnNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :board,         foreign_key: true
    add_reference :notifications, :board_comment, foreign_key: true
  end
end

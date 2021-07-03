class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :visitor, class_name: "User"
  belongs_to :visited, class_name: "User"
  belongs_to :board_comment, optional: true
  belongs_to :board,         optional: true
  belongs_to :comment,       optional: true
  belongs_to :review,        optional: true

  validates :visitor_id, presence: true
  validates :visited_id, presence: true
  ACTION_VALUES = %w[like follow comment board_comment]
  validates :action, presence: true, inclusion: {in: ACTION_VALUES}
  validates :checked, inclusion: {in: [true, false]}
end

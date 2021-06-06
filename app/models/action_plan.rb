class ActionPlan < ApplicationRecord
  belongs_to :review

  validates :plan, presence: true
  validates :deadline, presence: true
  validates :progress, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 1
  }
end

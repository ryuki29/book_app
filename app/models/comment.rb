class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :review

  validates :text, presence: true

  scope :asc, -> { order(created_at: :asc) }
end

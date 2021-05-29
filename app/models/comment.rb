class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :review

  validates :text, presence: true
end

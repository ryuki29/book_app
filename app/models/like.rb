class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :review_id, uniqueness: { scope: :user_id }
end

class BoardComment < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :text, presence: true, length: { maximum: 200 }
end

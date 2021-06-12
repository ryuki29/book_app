class Board < ApplicationRecord
  belongs_to :user
  has_many :comments, class_name: 'BoardComment', dependent: :destroy
  has_one_attached :image

  enum board_type: {
    question:  0,
    recommend: 1,
    chat:      2
  }

  validates :title,       presence: true, length: { maximum: 25 }
  validates :board_type,  presence: true
  validates :description, presence: true, length: { maximum: 200 }

  def self.search(search)
    return Board.all unless search
    Board.where('title LIKE(?)', "%#{search}%").or(where('description LIKE(?)', "%#{search}%"))
  end
end

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

  scope :recent, -> { order(created_at: :desc) }

  paginates_per 10

  def self.search(search)
    return Board.all unless search
    Board.where('title LIKE(?)', "%#{search}%").or(where('description LIKE(?)', "%#{search}%"))
  end

  def self.board_ranks
    Board.find(BoardComment.group(:board_id).order('count(board_id) desc').limit(5).pluck(:board_id))
  end
end

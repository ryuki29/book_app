class Review < ApplicationRecord
  has_many :action_plans, dependent: :destroy
  accepts_nested_attributes_for :action_plans, allow_destroy: true
  has_many :impressive_phrases, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :impressive_phrases, allow_destroy: true
  belongs_to :book, dependent: :destroy
  belongs_to :user

  enum category: {
    it:         0, # IT
    management: 1, # 経営戦略
    economy:    2, # 政治・経済・社会
    finance:    3, # ファイナンス
    thinking:   4, # 思考法
    motivation: 5, # 自己啓発
    novel:      6, # 小説
    etc:        7, # その他
  }

  validates :category, presence: true
  validates :tegline, presence: true, length: { maximum: 25 }
  validates :text, length: { maximum: 400 }
  validates :rating, numericality: {
    less_than: 6,
    greater_than_or_equal_to: 0,
    allow_blank: true
  }
end

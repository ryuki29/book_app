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
    literature: 0,
    nonfiction: 1,
    business_economy: 2,
    history_geography: 3,
    political_society: 4,
    humanities_thoughts_religions: 5,
    science_technology: 6,
    self_enlightenment: 7,
    etc: 8
  }

  validates :category, presence: true

end

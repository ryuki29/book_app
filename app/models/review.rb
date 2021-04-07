class Review < ApplicationRecord
  has_many :action_plans, dependent: :destroy
  accepts_nested_attributes_for :action_plans, allow_destroy: true
  has_many :impressive_phrases, dependent: :destroy
  accepts_nested_attributes_for :impressive_phrases, allow_destroy: true
  belongs_to :book
  belongs_to :user
end

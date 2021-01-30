class Review < ApplicationRecord
  has_many :action_plans, dependent: :destroy
  has_many :impressive_phrases, dependent: :destroy
end

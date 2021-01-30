class Review < ApplicationRecord
  has_many :action_plans, dependent: :destroy
end

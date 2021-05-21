class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  with_options presence: true do
    validates :follower_id
    validates :followed_id
  end

  validates :follower_id, uniqueness: { scope: :followed_id }
end

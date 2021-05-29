class Review < ApplicationRecord
  has_many :action_plans, dependent: :destroy
  accepts_nested_attributes_for :action_plans, allow_destroy: true
  has_many :impressive_phrases, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
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

  def self.search(search)
    return Review.all unless search
    Review.where('text LIKE(?)', "%#{search}%").or(where('tegline LIKE(?)', "%#{search}%"))
  end

  # --------------------いいね通知--------------------
  def create_notification_like(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ?",
                                current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        review_id: id,
        visited_id: user_id,
        action: 'like'
      )

      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # --------------------コメント通知--------------------
  def create_notification_comment(current_user, comment_id)
    temp_ids = Comment.where(review_id: id).where.not("user_id=? or user_id=?", current_user.id, user_id).select(:user_id).distinct

    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment(current_user, comment_id, user_id)
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      review_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end

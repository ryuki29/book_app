module NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    @visitor_comment = notification.comment_id

    case notification.action
    when 'follow'
      tag.a(@visitor.username, href: user_path(@visitor)) + "があなたをフォローしました"
    when 'like'
      tag.a(@visitor.username, href: user_path(@visitor)) + "が" + tag.a("あなたの投稿", href: review_path(notification.review_id)) + "にいいねしました"
    when 'comment' then
      @comment = Comment.find_by(id: @visitor_comment)
      @comment_text = @comment.text
      tag.a(@visitor.username, href: user_path(@visitor)) + "が" + tag.a("あなたの投稿", href: review_path(notification.review_id)) + "にコメントしました"
    when 'board_comment' then
      @board_comment = BoardComment.find_by(id: @visitor_board_comment)
      tag.a(@visitor.username, href: user_path(@visitor)) + "が" + tag.a("スレッド", href: board_path(notification.board_id)) + "にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '#create' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    let(:board) { create(:board) }
    let(:board_comment) { create(:comments) }

    context 'レビュー関連の通知' do
      let(:review) { create(:review) }

      it 'いいねが行われたときに保存される' do
        like = build(:like)
        notification = build(:notification, visitor_id: user.id, visited_id: other_user.id, review_id: review.id,
                                            action: 'like')
        expect(notification).to be_valid
      end

      it 'コメントが行われたときに保存される' do
        comment = build(:comment)
        notification = build(:notification, visitor_id: user.id, visited_id: other_user.id, review_id: review.id,
                                            action: 'comment')
        expect(notification).to be_valid
      end
    end

    context 'フォロー関連の通知' do
      it 'フォローされたときに保存される' do
        notification = build(:notification, visitor_id: user.id, visited_id: other_user.id, action: 'follow')
        expect(notification).to be_valid
      end
    end
  end
end

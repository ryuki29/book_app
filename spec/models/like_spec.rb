require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { create(:like) }
  describe '#create' do
    context 'likeを保存できる場合' do
      it 'review_idとuser_idがあれば保存できる' do
        expect(like).to be_valid
      end

      it 'review_idが同じでもuser_idが違うこと' do
        expect(FactoryBot.create(:like, review_id: like.review_id)).to be_valid
      end

      it 'user_idが同じでもreview_idが違うこと' do
        expect(FactoryBot.create(:like, user_id: like.user_id)).to be_valid
      end
    end

    context 'likeを保存できない場合' do
      it 'review_idが存在しないと保存できないこと' do
        like.review_id = ''
        expect(like).to be_invalid
      end

      it 'user_idが存在しないと保存できないこと' do
        like.user_id = ''
        expect(like).to be_invalid
      end
    end

    context '一意性の検証' do
      it 'review_idとuser_idの組み合わせは一意であること' do
        another_like = build(:like, review_id: like.review_id, user_id: like.user_id)
        expect(another_like).to be_invalid
      end
    end
  end

  describe '#destroy' do
  end
end

require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @review = FactoryBot.build(:review)
  end

  describe 'レビューの保存' do
    context 'レビューが投稿できる場合' do
      it 'すべてのフォームに情報が入力されていれば投稿できる' do
        expect(@review).to be_valid
      end
      it '日付がなくても投稿できる' do
        @review.date = ''
        expect(@review).to be_valid
      end
      it 'レーティングがなくても投稿できる' do
        @review.rating = ''
        expect(@review).to be_valid
      end
    end

    context 'レビューが投稿できない場合' do
      it 'ジャンルが空だと投稿できない' do
        @review.category = ''
        @review.valid?
        expect(@review.errors.full_messages).to include('Categoryを入力してください')
      end
      it '一言が空だと投稿できない' do
        @review.tegline = ''
        @review.valid?
        expect(@review.errors.full_messages).to include('Teglineを入力してください')
      end
      it '一言が26文字以上だと投稿できない' do
        @review.tegline = 'a' * 26
        @review.valid?
        expect(@review.errors.full_messages).to include('Teglineは25文字以内で入力してください')
      end
      it '感想が401字以上だと投稿できない' do
        @review.text = 'a' * 401
        @review.valid?
        expect(@review.errors.full_messages).to include('Textは400文字以内で入力してください')
      end
      it 'レーティングが-1以下だと投稿できない' do
        @review.rating = -1
        @review.valid?
        expect(@review.errors.full_messages).to include('Ratingは0以上の値にしてください')
      end
      it 'レーティングが6つ以上だと投稿できない' do
        @review.rating = 6
        @review.valid?
        expect(@review.errors.full_messages).to include('Ratingは6より小さい値にしてください')
      end
      it '本が紐付いていなければ投稿できない' do
        @review.book = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('Bookを入力してください')
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @review.user = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end

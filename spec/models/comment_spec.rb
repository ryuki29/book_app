require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントの保存' do
    context 'コメントが投稿できる場合' do
      it 'テキストがあれば投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントが投稿できない場合' do
      it 'テキストが空では投稿できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Textを入力してください')
      end
      it 'ユーザーが紐付いていないとコメントは保存できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Userを入力してください')
      end
      it 'ユーザーが紐付いていないとコメントは保存できない' do
        @comment.review = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Reviewを入力してください')
      end
    end
  end
end

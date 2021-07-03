require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { create(:message) }
  describe '#create' do
    context '保存できるとき' do
      it 'すべてのパラメーターが揃っていれば保存できる' do
        expect(message).to be_valid
      end

      it 'messageが1文字以上なら保存できる' do
        message.message = 'a' * 1
        expect(message).to be_valid
      end

      it 'messageが200文字以内なら保存できる' do
        message.message = 'a' * 200
        expect(message).to be_valid
      end
    end

    context '保存できないとき' do
      it 'user_idがnilの場合は保存できない' do
        message.user_id = nil
        expect(message).to be_invalid
        # ↑上の場合だと、本当にuser_idが空でinvalidになったのかがわからない
        # ↓下の場合だと、user_idが原因だとわかるのではないか？
        message.valid?
        expect(message.errors[:user]).to include 'を入力してください'
      end

      it 'room_idがnilの場合は保存できない' do
        message.room_id = nil
        message.valid?
        expect(message.errors[:room]).to include 'を入力してください'
      end

      it 'messageがnilの場合は保存できない' do
        message.message = nil
        message.valid?
        expect(message.errors[:message]).to include 'を入力してください'
      end

      it 'messageが200文字以上の場合は保存できない' do
        message.message = 'a' * 201
        message.valid?
        expect(message.errors[:message]).to include 'は200文字以内で入力してください'
      end
    end
  end
end

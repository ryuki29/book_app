require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @book = FactoryBot.build(:book)
  end

  describe '本の登録' do
    context '登録できるとき' do
      it 'すべての項目が揃っていれば登録できる' do
        expect(@book).to be_valid
      end
    end

    context '本が登録できないとき' do
      it 'uidが空では登録できない' do
        @book.uid = nil
        @book.valid?
        expect(@book.errors.full_messages).to include('Uidを入力してください')
      end
      it 'image_urlが空では登録できない' do
        @book.image_url = nil
        @book.valid?
        expect(@book.errors.full_messages).to include('Image urlを入力してください')
      end
    end
  end
end

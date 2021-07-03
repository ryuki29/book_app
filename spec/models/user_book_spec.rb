require 'rails_helper'

RSpec.describe UserBook, type: :model do
  before do
    @user_book = FactoryBot.build(:user_book)
  end

  describe 'UserBookの登録' do
    context 'UserBookが登録できるとき' do
      it 'すべての項目が存在すれば登録できる' do
        expect(@user_book).to be_valid
      end
    end

    context 'UserBookが登録できないとき' do
      it 'statusが3以上の場合登録できない' do
        @user_book.status = 3
        @user_book.valid?
        expect(@user_book.errors.full_messages).to include 'Statusは2以下の値にしてください'
      end
    end
  end
end

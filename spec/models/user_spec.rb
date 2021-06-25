require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'usernameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        expect(@user).to be_valid
      end

      context '新規登録できないとき' do
        it 'usernameが空では登録できない' do
          @user.username = ''
          @user.valid?
          expect(@user.errors.full_messages).to include 'Usernameを入力してください'
        end
        it 'emailが空では登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include 'メールアドレスが入力されていません。'
        end
        it 'passwordが空では登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include 'パスワードが入力されていません。'
        end
        it 'passwordが存在してもpassword_confirmationが空では登録できない' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include '確認用パスワードとパスワードの入力が一致しません'
        end
        it 'usernameが20文字以上では登録できない' do
          @user.username = 'a' * 21
          @user.valid?
          expect(@user.errors.full_messages).to include 'Usernameは20文字以内で入力してください'
        end
        it '重複したemailが存在する場合登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include 'メールアドレスは既に使用されています。'
        end
        it 'emailに@が無ければ登録できない' do
          @user.email = 'aa'
          @user.valid?
          expect(@user.errors.full_messages).to include 'メールアドレスは有効でありません。'
        end
        it 'emailに.が無ければ登録できない' do
          @user.email = 'aa@bb'
          @user.valid?
          expect(@user.errors.full_messages).to include 'メールアドレスは有効でありません。'
        end
        it 'passwordが5文字以下では登録できない' do
          @user.password = '00000'
          @user.password_confirmation = '00000'
          @user.valid?
          expect(@user.errors.full_messages).to include 'パスワードは6文字以上に設定して下さい。'
        end
        it '自己紹介文が101文字だと登録できない' do
          @user.profile = 'a' * 161
          @user.valid?
          expect(@user.errors.full_messages).to include 'Profileは160文字以内で入力してください'
        end
      end
    end
  end
end

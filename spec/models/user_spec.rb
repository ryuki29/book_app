require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'usernameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(user).to be_valid
      end

      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        user.password = '000000'
        user.password_confirmation = '000000'
        expect(user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'usernameが空では登録できない' do
        user.username = ''
        user.valid?
        expect(user.errors[:username]).to include 'を入力してください'
      end

      it 'emailが空では登録できない' do
        user.email = ''
        user.valid?
        expect(user.errors[:email]).to include 'が入力されていません。'
      end

      it 'passwordが空では登録できない' do
        user.password = ''
        user.valid?
        expect(user.errors[:password]).to include 'が入力されていません。'
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        user.password_confirmation = ''
        user.valid?
        expect(user.errors[:password_confirmation]).to include 'とパスワードの入力が一致しません'
      end

      it 'usernameが21文字以上では登録できない' do
        user.username = 'a' * 21
        user.valid?
        expect(user.errors[:username]).to include 'は20文字以内で入力してください'
      end

      it '重複したemailが存在する場合登録できない' do
        user.save
        another_user = FactoryBot.build(:user)
        another_user.email = user.email
        another_user.valid?
        expect(another_user.errors[:email]).to include 'は既に使用されています。'
      end

      it 'emailに@が無ければ登録できない' do
        user.email = 'aa'
        user.valid?
        expect(user.errors[:email]).to include 'は有効でありません。'
      end

      it 'emailに.が無ければ登録できない' do
        user.email = 'aa@bb'
        user.valid?
        expect(user.errors[:email]).to include 'は有効でありません。'
      end

      it 'passwordが5文字以下では登録できない' do
        user.password = '00000'
        user.password_confirmation = '00000'
        user.valid?
        expect(user.errors[:password]).to include 'は6文字以上に設定して下さい。'
      end

      it '自己紹介文が161文字以上だと登録できない' do
        user.profile = 'a' * 161
        user.valid?
        expect(user.errors[:profile]).to include 'は160文字以内で入力してください'
      end
    end
  end

  describe 'followとunfollow' do
    let(:other_user) { create(:user) }

    before { user.follow(other_user) }

    context '他のユーザーをフォローするとき' do
      it 'フォローが保存できる' do
        expect(user.following?(other_user)).to be_truthy
      end
    end

    context '他のユーザーのフォローを解除するとき' do
      it 'フォローが解除できる' do
        user.unfollow(other_user)
        expect(user.following?(other_user)).to be_falsy
      end
    end
  end

  describe '削除依存性の検証' do
    let(:other_user) { create(:user) }

    it '削除すると紐づくsnsアカウントも削除される' do
      create(:sns_credential, user: user)
      expect { user.destroy }.to change(user.sns_credentials, :count).by(-1)
    end

    it '削除すると紐づく投稿も削除される' do
      create(:review, user: user)
      expect { user.destroy }.to change(user.reviews, :count).by(-1)
    end

    it '削除すると紐づく本も削除される' do
      create(:user_book, user: user)
      expect { user.destroy }.to change(user.user_books, :count).by(-1)
    end

    it '削除すると紐づくブックマークも削除される' do
      create(:like, user: user)
      expect { user.destroy }.to change(user.likes, :count).by(-1)
    end

    it '削除すると紐づくコメントも削除される' do
      create(:comment, user: user)
      expect { user.destroy }.to change(user.comments, :count).by(-1)
    end

    it '削除すると紐づくフォローも削除されること' do
      user.follow(other_user)
      expect { user.destroy }.to change(user.following, :count).by(-1)
    end

    it '削除すると紐づくフォロワーも削除されること' do
      user.follow(other_user)
      expect { user.destroy }.to change(other_user.followers, :count).by(-1)
    end

    it '削除すると紐づくエントリーも削除されること' do
      create(:entry, user: user)
      expect { user.destroy }.to change(user.entries, :count).by(-1)
    end

    it '削除すると紐づくメッセージも削除されること' do
      create(:message, user: user)
      expect { user.destroy }.to change(user.messages, :count).by(-1)
    end
  end
end

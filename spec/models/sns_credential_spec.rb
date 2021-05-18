require 'rails_helper'

RSpec.describe SnsCredential, type: :model do
  before do
    @sns_credential = FactoryBot.build(:sns_credential)
  end

  describe 'SNSアカウント登録' do
    context 'アカウント登録できるとき' do
      it 'すべての項目が存在すれば登録できる' do
        expect(@sns_credential).to be_valid
      end
      it 'providerがTwitterであれば登録できる' do
        @sns_credential.provider = 'twitter'
        @sns_credential.valid?
        expect(@sns_credential).to be_valid
      end
    end

    context 'アカウントが登録できないとき' do
      it 'providerが空では登録できない' do
        @sns_credential.provider = ''
        @sns_credential.valid?
        expect(@sns_credential.errors.full_messages).to include('Providerを入力してください')
      end
      it 'providerがTwitter以外では登録できない' do
        @sns_credential.provider = 'GitHub'
        @sns_credential.valid?
        expect(@sns_credential.errors.full_messages).to include('Providerは一覧にありません')
      end
      it 'uidが空では登録できない' do
        @sns_credential.uid = ''
        @sns_credential.valid?
        expect(@sns_credential.errors.full_messages).to include('Uidを入力してください')
      end
      it 'ユーザーが紐付いていなければ登録できない' do
        @sns_credential.user = nil
        @sns_credential.valid?
        expect(@sns_credential.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end

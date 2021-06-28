require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      #新規登録をクリックする
      find('button#signup-toggle').click
      # ユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_username', with: @user.username
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # ヘッダーにログアウトボタンが表示されていることを確認する
      expect(
        find('.header__right').find('.pc').find('.nav__wrapper').find('#nav__sign_out')
      ).to have_content('ログアウト')
      # 新規登録/ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録/ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      #新規登録をクリックする
      find('button#signup-toggle').click
      # ユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_username', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end
require 'rails_helper'
describe UsersController, type: :request do
  let!(:user) { create(:user) }

  describe '#index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get users_path(user)
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとユーザー名が表示されている' do
      get users_path
      expect(response.body).to include user.username
    end
  end

  describe '#show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get user_path(user)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとユーザー名が表示されている' do
      get user_path(user)
      expect(response.body).to include user.username
    end
  end

  describe '#following' do
    it 'followingアクションにリクエストすると正常にレスポンスが返ってくる' do
      get following_user_path(user)
      expect(response.status).to eq 200
    end
  end

  describe '#followers' do
    it 'followersアクションにリクエストすると正常にレスポンスが返ってくる' do
      get followers_user_path(user)
      expect(response.status).to eq 200
    end
  end
end

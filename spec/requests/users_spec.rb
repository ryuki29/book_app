require 'rails_helper'
describe UsersController, type: :request do

  before do
    @user = FactoryBot.create(:user)
  end

  describe '#show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get user_path(@user)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとユーザー名が表示されている' do
      get user_path(@user)
      expect(response.body).to include(@user.username)
    end
  end
end
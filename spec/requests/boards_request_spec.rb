require 'rails_helper'

RSpec.describe 'Boards', type: :request do
  describe '#index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get boards_path
      expect(response).to have_http_status(:success)
    end
  end

  # describe "#show" do
  #   it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
  #     get "/boards/show"
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end

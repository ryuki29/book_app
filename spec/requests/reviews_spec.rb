require 'rails_helper'
describe ReviewsController, type: :request do

  before do
    @review = FactoryBot.create(:review)
    @review.user = FactoryBot.create(:user)
  end

  describe '#index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのレビューのテキストが存在する' do
      get root_path
      expect(response.body).to include(@review.text)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのレビューの一言が存在する' do
      get root_path
      expect(response.body).to include(@review.tegline)
    end
  end

  describe '#show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get review_path(@review)
      expect(response.status).to eq 200
    end
    it 'テキストが存在する' do
      get review_path(@review)
      expect(response.body).to include(@review.text)
    end
  end

end
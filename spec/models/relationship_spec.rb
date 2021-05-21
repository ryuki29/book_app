require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe '#create' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context '正常に保存できる場合' do
      let(:relationship) do
        create(
          :relationship,
          follower_id: user.id,
          followed_id: other_user.id
        )
      end

      it 'relationshipを登録できる' do
        expect(relationship).to be_valid
      end
    end

    context '保存できない場合' do
      let(:relationship) do
        create(
          :relationship,
          follower_id: user.id,
          followed_id: other_user.id
        )
      end

      it 'follower_idが存在しないと保存できない' do
        relationship.follower_id = nil
        expect(relationship).to be_invalid
      end

      it 'followed_idが存在しないと保存できない' do
        relationship.followed_id = nil
        expect(relationship).to be_invalid
      end
    end

    context '一意性の確認' do
      let(:relationship) do
        create(
          :relationship,
          follower_id: user.id,
          followed_id: other_user.id
        )
      end

      it 'follower_idとfollowed_idの組み合わせは一意である' do
        uniquness_relationship = build(
          :relationship,
          follower_id: relationship.follower_id,
          followed_id: relationship.followed_id
        )
        expect(uniquness_relationship).to be_invalid
      end
    end
  end

  describe 'アソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'User(follower)モデルとの関係' do
      let(:target) { :follower }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス：User' do
        expect(association.class_name).to eq 'User'
      end
    end

    context 'User(followed)モデルとの関係' do
      let(:target) { :followed }
      it '多：1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス：User' do
        expect(association.class_name).to eq 'User'
      end
    end
  end
end

require 'rails_helper'

RSpec.describe ActionPlan, type: :model do
  before do
    @review = FactoryBot.build(:review)
    @review.action_plan = FactoryBot.build(:action_plan)
  end

  describe 'アクションプランの登録' do
    context '登録できるとき' do
      it 'すべての項目が揃っていれば登録できる' do
        expect(@review.action_plan).to be_valid
      end
    end

    context '登録できないとき' do
      it 'planが空では登録できない' do
        @review.action_plan.plan = nil
        @review.action_plan.valid?
        expect(@review.action_plan.errors[:plan]).to include('を入力してください')
      end

      it 'deadlineが空では登録できない' do
        @review.action_plan.deadline = nil
        @review.action_plan.valid?
        expect(@review.action_plan.errors[:deadline]).to include('を入力してください')
      end

      it 'progressが空では登録できない' do
        @review.action_plan.progress = nil
        @review.action_plan.valid?
        expect(@review.action_plan.errors[:progress]).to include('は数値で入力してください')
      end

      it 'progressは数値でないと登録できない' do
        @review.action_plan.progress = 'a'
        @review.action_plan.valid?
        expect(@review.action_plan.errors[:progress]).to include('は数値で入力してください')
      end

      it 'progressが2以上では登録できない' do
        @review.action_plan.progress = 2
        @review.action_plan.valid?
        expect(@review.action_plan.errors[:progress]).to include('は1以下の値にしてください')
      end
    end
  end
end

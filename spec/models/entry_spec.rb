require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'エントリー機能' do
    let(:entry) { create(:entry) }

    context '保存できるとき' do
      it 'user_idとroom_idがあれば保存できる' do
        expect(entry).to be_valid
      end
    end

    context '保存できないとき' do
      it 'user_idがnilだと保存できない' do
        entry.user_id = nil
        entry.valid?
        expect(entry.errors[:user]).to include 'を入力してください'
      end

      it 'room_idがnilだと保存できない' do
        entry.room_id = nil
        entry.valid?
        expect(entry.errors[:room]).to include 'を入力してください'
      end
    end
  end
end

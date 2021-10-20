require 'rails_helper'

RSpec.describe Quest, type: :model do
  before do
    @quest = FactoryBot.build(:quest)
  end

  describe 'ボランティア募集' do
    context 'ボランティア募集ができるとき' do
      it '全ての項目を入力している' do
        @quest.valid?
        expect(@quest).to be_valid
      end
      it '画像以外は入力できている' do
        @quest.image = nil
        @quest.valid?
        expect(@quest).to be_valid
      end
      it '報酬形態以外は入力できている' do
        @quest.reward = ""
        @quest.valid?
        expect(@quest).to be_valid
      end
      it 'アピールポイント以外は入力できている' do
        @quest.point = ""
        @quest.valid?
        expect(@quest).to be_valid
      end
      it '募集詳細以外は入力できている' do
        @quest.detail = ""
        @quest.valid?
        expect(@quest).to be_valid
      end
      it '画像、報酬形態、アピールポイント、募集詳細以外は入力できている' do
        @quest.image = nil
        @quest.reward = ""
        @quest.point = ""
        @quest.detail = ""
        @quest.valid?
        expect(@quest).to be_valid
      end
    end

    describe 'ボランティア募集ができないとき' do
      it 'タイトルを入力していないとき' do
        @quest.title = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("タイトルを入力してください")
      end
      it '募集予定人数を入力していないとき' do
        @quest.capacity = ''
        @quest.valid?
        expect(@quest.errors.full_messages).to include("募集予定人数を入力してください")
      end
      it '募集予定人数が数字以外のとき' do
        @quest.capacity = "aiueo"
        @quest.valid?
        expect(@quest.errors.full_messages).to include("募集予定人数が人数制限の範囲外または数字以外で入力されています")
      end
      it '募集予定人数が11人以上のとき' do
        @quest.capacity = 11
        @quest.valid?
        expect(@quest.errors.full_messages).to include("募集予定人数が人数制限の範囲外または数字以外で入力されています")
      end
      it '募集予定人数が0人以下のとき' do
        @quest.capacity = 0
        @quest.valid?
        expect(@quest.errors.full_messages).to include("募集予定人数が人数制限の範囲外または数字以外で入力されています")
      end
      it '活動日が入力されていないとき' do
        @quest.date = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("活動日を入力してください")
      end
      it '活動日をカレンダー指定で入力していないとき' do
        @quest.date = "2021年10月1日"
        @quest.valid?
        expect(@quest.errors.full_messages).to include("活動日を入力してください")
      end
      it '応募者資格を入力していないとき' do
        @quest.target = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("応募者資格を入力してください")
      end
      it '応募者対象者を選択していないとき' do
        @quest.target_attribute_id = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("応募対象者を選択してください")
      end
      it '活動地域が選択されていないとき' do
        @quest.place_id = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("活動地域を選択してください")
      end
    end
  end
end

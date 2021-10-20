require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
    send_user = FactoryBot.create(:user)
    @message.sending_party_id = send_user.id
  end

  describe 'メッセージを送信' do
    context 'メッセージを送れるとき' do
      it '評価相手とメッセージ、５段階評価を入力している' do
        @message.valid?
        expect(@message).to be_valid
      end
    end

    context 'メッセージを送れないとき' do
      it '評価相手を選択していないとき' do
        @message.sending_party_id = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Sending partyを入力してください")
      end
      it 'メッセージを入力していないとき' do
        @message.message = ""
        @message.valid?
        expect(@message.errors.full_messages).to include("Messageを入力してください")
      end
      it '5段階評価をしていないとき' do
        @message.like = ''
        @message.valid?
        expect(@message.errors.full_messages).to include("Likeを入力してください")
      end
      it '送付元ユーザーが紐づいていないとき' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Userを入力してください")
      end
      it 'クエストが紐づいていないとき' do
        @message.quest = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Questを入力してください")
      end
      it 'メッセージが101文字以上の場合' do
        @message.message = Faker::Lorem.characters(number: 101)
        @message.valid?
        expect(@message.errors.full_messages).to include("Messageは100文字以内で入力してください")
      end
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'last_name,first_name,email,password,password_confirmationが入力されている' do
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'last_nameが空のとき' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it 'first_nameが空のとき' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it 'emailが空のとき' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空のとき' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'password_confirmationが空のとき' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'emailに@がないとき' do
        @user.email = "testtest"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'emailが既に登録済みのものであったとき' do
        user2 = FactoryBot.create(:user)
        @user.email = user2.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'パスワードが6文字未満のとき' do
        @user.password = "qaz12"
        @user.password_confirmation = "qaz12"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'パスワードに半角英字しかないないとき' do
        @user.password = "qazwsx"
        @user.password_confirmation = "qazwsx"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の両方を含めて入力してください")
      end
      it 'パスワードに半角数字しかないないとき' do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の両方を含めて入力してください")
      end
      it 'パスワードに全角文字があるとき' do
        @user.password = "ｑazw12"
        @user.password_confirmation = "ｑazw12"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の両方を含めて入力してください")
      end
      it 'パスワードとパスワード（確認）の値が一致していないとき' do
        @user.password = "qaz123"
        @user.password_confirmation = "ujm789"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'last_nameに全角漢字・ひらがな・カタカナ以外があるとき' do
        @user.last_name = "Ｔ郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は全角文字（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'last_nameに半角文字があるとき' do
        @user.last_name = "t郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は全角文字（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'first_nameに全角漢字・ひらがな・カタカナ以外があるとき' do
        @user.first_name = "Ｔ中"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角文字（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'first_nameに半角文字があるとき' do
        @user.first_name = "t中"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角文字（漢字・ひらがな・カタカナ）で入力してください")
      end
    end
  end
end

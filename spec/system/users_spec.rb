require 'rails_helper'

RSpec.describe "新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー登録できるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      #トップページに移動する
      basic_path(root_path)
      #トップページに新規登録ボタンがある
      expect(page).to have_content('新規登録')
      #新規登録ページに移動する
      visit new_user_registration_path
      #ユーザー情報を入力する
      fill_in 'Family name(苗字)', with: @user.last_name
      fill_in 'First name(名前)', with: @user.first_name
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in 'パスワード（確認用）', with: @user.password_confirmation
      #登録するボタンを押すとUserモデルのカウントが１上がる（登録完了）
      expect{find('input[name="commit"]').click}.to change { User.count }.by(1)
      #トップページへ遷移している
      expect(current_path).to eq(root_path)
      #トップページにマイページとログアウトボタンが表示されている
      expect(page).to have_content('マイページ')
      expect(page).to have_content('ログアウト')
      #トップページに新規登録とログインボタンの表示がされていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー登録できないとき' do
    it '謝った情報ではユーザー新規登録ができずに新規登録ページに戻ってくる' do
      #トップページに移動する
      basic_path(root_path)
      #トップページに新規登録ボタンがある
      expect(page).to have_content('新規登録')
      #新規登録ページに移動する
      visit new_user_registration_path
      #ユーザー情報を入力する
      fill_in 'Family name(苗字)', with: ''
      fill_in 'First name(名前)', with: ''
      fill_in 'Eメール', with: ''
      fill_in 'パスワード', with: ''
      fill_in 'パスワード（確認用）', with:''
      #登録するボタンを押してもUserモデルのカウントが１上がらない
      expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
      #新規登録ページへ戻されている
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインできるとき' do
    it '正しい情報を入力すればログインができてトップページに移動する' do
      #トップページに移動する
      basic_path(root_path)
      #トップページに新規登録ボタンがある
      expect(page).to have_content('ログイン')
      #新規登録ページに移動する
      visit new_user_session_path
      #ユーザー情報を入力する
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      #ログインボタンを押す
      find('input[name="commit"]').click
      #トップページへ遷移している
      expect(current_path).to eq(root_path)
      #トップページにマイページとログアウトボタンが表示されている
      expect(page).to have_content('マイページ')
      expect(page).to have_content('ログアウト')
      #トップページに新規登録とログインボタンの表示がされていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインできないとき' do
    it '謝った情報ではログインができずにログインページに戻ってくる' do
      #トップページに移動する
      basic_path(root_path)
      #トップページに新規登録ボタンがある
      expect(page).to have_content('ログイン')
      #新規登録ページに移動する
      visit new_user_session_path
      #ユーザー情報を入力する
      fill_in 'Eメール', with: ''
      fill_in 'パスワード', with: ''
      #ログインボタンを押す
      find('input[name="commit"]').click
      #ログインページに戻されている
      expect(current_path).to eq new_user_session_path
    end
  end
end
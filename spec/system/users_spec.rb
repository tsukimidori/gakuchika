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

RSpec.describe "登録内容の変更", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @image_oth = Rails.root.join('public/images/test2.png')
  end

  context '登録の変更ができるとき' do
    it '正しい情報を入力すると登録内容の変更ができ、マイページに移動する' do
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user)
      #マイページに遷移すると編集するボタンが表示されていることを確認する
      visit user_path(@user)
      expect(page).to have_link '編集する', href: edit_user_registration_path(@user)
      #編集するボタンを押すと編集ページに遷移することを確認する
      find_link('編集する').click
      expect(current_path).to eq(edit_user_registration_path(@user))
      #編集ページには画像とパスワードを除く登録内容がフォームに入っていることを確認する
      expect(find_by_id('user_last_name').value).to eq(@user.last_name)
      expect(find_by_id('user_first_name').value).to eq(@user.first_name)
      expect(find_by_id('user_profile').value).to eq("")  #ユーザー登録時の初期値はnilのため
      expect(find_by_id('user_email').value).to eq(@user.email)
      #編集を行い登録変更ボタンを押すとUserモデルのカウントは上がらずにマイページに遷移する
      attach_file('user[avatar]', @image_oth, make_visible: true)
      fill_in 'Family name(苗字)', with: '山田'
      fill_in 'First name(名前)', with: '花子'
      fill_in 'プロフィール', with: 'テストテキスト'
      fill_in 'Eメール', with: 'test@test'
      fill_in 'パスワード（変更）', with: 'tgb123'
      fill_in 'パスワード（変更確認用）', with: 'tgb123'
      fill_in 'パスワード', with: @user.password
      expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
      expect(current_path).to eq(user_path(@user))
      #マイページに編集内容が反映されていることを確認
      expect(page).to have_selector("img[src$='test2.png']")
      expect(page).to have_content('山田花子')
      expect(page).to have_content('test@test')
      expect(page).to have_content('テストテキスト')
    end
    it '画像、プロフィール以外を入力していれば募集内容の変更ができマイページへ遷移する' do
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user)
      #マイページに遷移し編集ページに遷移する
      visit user_path(@user)
      find_link('編集する').click
      expect(current_path).to eq(edit_user_registration_path(@user))
      #画像、プロフィール以外を入力し登録変更ボタンを押すとUserモデルのカウントは上がらずにマイページに遷移する
      fill_in 'Family name(苗字)', with: '山田'
      fill_in 'First name(名前)', with: '花子'
      fill_in 'Eメール', with: 'test@test'
      fill_in 'パスワード（変更）', with: 'tgb123'
      fill_in 'パスワード（変更確認用）', with: 'tgb123'
      fill_in 'パスワード', with: @user.password
      expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
      expect(current_path).to eq(user_path(@user))
      #マイページに編集内容が反映されていることを確認
      expect(page).to have_content('山田花子')
      expect(page).to have_content('test@test')
    end
  end
  context '登録の変更ができないとき' do
    it 'ログイン状態でないときはマイページが表示されないため募集できない' do
      #トップページに遷移する
      basic_path(root_path)
      #マイページが表示されていない
      expect(page).to have_no_content('マイページ')
    end
    it '他人のマイページでは編集するボタンが表示されない' do
      user_oth = FactoryBot.create(:user)
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user)
      #別のユーザーのマイページへ遷移
      visit user_path(user_oth)
      #ボランティアを募集するボタンが表示されていない
      expect(page).to have_no_content('編集する')
    end
  end
end
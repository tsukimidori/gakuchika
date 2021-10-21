require 'rails_helper'

RSpec.describe "ボランティア募集", type: :system do
  before do
    @quest = FactoryBot.build(:quest)
    @user = FactoryBot.create(:user)
  end
  
  context 'ボランティア募集できるとき' do
    image = Rails.root.join('public/images/test.png')

    it '正しい情報を全て入力するとボランティア募集ができトップページへ遷移する' do
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user)
      #自分のマイページに遷移する
      visit user_path(@user)
      #マイページ上に「ボランティアを募集する」のボタンがある
      expect(page).to have_content('ボランティアを募集する')
      #ボランティアの新規募集ページに遷移する
      visit new_quest_path
      #ボランティア情報を入力する
      attach_file('quest[image]', image, make_visible: true)
      fill_in 'タイトル', with: @quest.title
      fill_in '報酬形態', with: @quest.reward
      fill_in '募集予定人数', with: @quest.capacity
      fill_in '活動日', with: @quest.date
      fill_in '応募者資格', with: @quest.target
      fill_in 'アピールポイント', with: @quest.point
      select(@quest.place_name, from: 'quest[place_id]')
      select(@quest.target_attribute_name, from: 'quest[target_attribute_id]')
      fill_in '募集詳細', with: @quest.detail
      #投稿するボタンを押すとQuestモデルのカウントが1上がる
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(1)
      #トップページに遷移している
      expect(current_path).to eq(root_path)
      #トップページに投稿したボランティア募集が表示されている
      expect(page).to have_selector("img[src$='test.png']")
      expect(page).to have_content(@quest.title)
      expect(page).to have_content(@quest.user.last_name)
      expect(page).to have_content(@quest.user.first_name)
      expect(page).to have_content(@quest.capacity)
      expect(page).to have_content(@quest.date.strftime("%Y/%m/%d"))
      expect(page).to have_content(@quest.place_name)
    end
    it '画像、報酬形態、アピールポイント、募集詳細以外を入力するとボランティア募集ができトップページへ遷移する' do
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user)
      #自分のマイページに遷移する
      visit user_path(@user)
      #マイページ上に「ボランティアを募集する」のボタンがある
      expect(page).to have_content('ボランティアを募集する')
      #ボランティアの新規募集ページに遷移する
      visit new_quest_path
      #ボランティア情報を入力する
      fill_in 'タイトル', with: @quest.title
      fill_in '報酬形態', with: ''
      fill_in '募集予定人数', with: @quest.capacity
      fill_in '活動日', with: @quest.date
      fill_in '応募者資格', with: @quest.target
      fill_in 'アピールポイント', with: ''
      select(@quest.place_name, from: 'quest[place_id]')
      select(@quest.target_attribute_name, from: 'quest[target_attribute_id]')
      fill_in '募集詳細', with: ''
      #投稿するボタンを押すとQuestモデルのカウントが1上がる
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(1)
      #トップページに遷移している
      expect(current_path).to eq(root_path)
      #トップページに投稿したボランティア募集が表示されている（画像はデフォルトのもの「sky_00010.jpeg」）
      expect(page).to have_selector("img[src$='sky_00010.jpeg']")
      expect(page).to have_content(@quest.title)
      expect(page).to have_content(@quest.user.last_name)
      expect(page).to have_content(@quest.user.first_name)
      expect(page).to have_content(@quest.capacity)
      expect(page).to have_content(@quest.date.strftime("%Y/%m/%d"))
      expect(page).to have_content(@quest.place.name)
    end
  end
end

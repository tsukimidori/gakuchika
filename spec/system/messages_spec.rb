require 'rails_helper'

RSpec.describe "メッセージ送信（応募者側）", type: :system do
  before do
    @join = FactoryBot.create(:join)
    @user = @join.user    #応募者
    @quest = @join.quest
    @user_oth = FactoryBot.create(:user)
  end

  context 'メッセージを送信できるとき' do
    it '応募者は募集者に対してのみメッセージを送信できる' do
      #ボランティアに応募したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user)
      #募集要項ページに遷移し評価を送るタブに移動し、評価相手が募集者に固定されていることを確認する
      visit quest_path(@quest)
      click_on '評価を見る・送る'
      expect(page).to have_content(user_name(@quest.user))
      #メッセージと評価を記入し送信するとMessageモデルのカウント1上がり募集要項に遷移する
      fill_message
      expect{find('input[name="commit"]').click}.to change { Message.count }.by(1)
      expect(current_path).to eq(quest_path(@quest))
      #評価一覧にメッセージが表示されている。
      click_on '評価を見る・送る'
      expect(page).to have_content('テスト')
    end
  end
  context 'メッセージを送信できないとき' do
    it 'メッセージを送信済みの場合はメッセージ送信画面が表示されず「投稿者への評価は投稿済みです」と表示される' do
      #ボランティアに応募したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user)
      #募集要項ページに遷移し評価を記入し送信する
      visit quest_path(@quest)
      click_on '評価を見る・送る'
      fill_message
      expect{find('input[name="commit"]').click}.to change { Message.count }.by(1)
      #評価を見るタブに移動し、「氏名（@user）さんへの評価は投稿済みです」と表示されている
      click_on '評価を見る・送る'
      expect(page).to have_content("#{user_name(@quest.user)}さんへの評価は投稿済みです")
    end
    it '参加者ではない場合、「評価する」項目が表示されない' do
      user_oth = FactoryBot.create(:user)
      #ボランティアに応募していないユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(user_oth)
      #募集要項ページに遷移し評価を送るタブに移動しても「評価する」項目が表示されていない
      visit quest_path(@quest)
      click_on '評価を見る・送る'
      expect(page).to have_no_selector 'h5', text: '評価する'
    end
  end
end

RSpec.describe "メッセージ送信（募集者側）", type: :system do
  before do
    @join = FactoryBot.create(:join)
    @quest = @join.quest
    @user = @quest.user   #募集者
    @user_oth = FactoryBot.create(:user)
  end

  context 'メッセージを送信できるとき' do
    it '募集者は応募者に対してのみメッセージを送信できる' do
      #ボランティアに応募したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user)
      #募集要項ページに遷移し評価を送るタブに移動し、評価を記入し送信するとMessageモデルのカウント1上がり募集要項に遷移する
      visit quest_path(@quest)
      click_on '評価を見る・送る'
      select("#{user_name(@join.user)}", from: 'message[sending_party_id]')
      fill_message
      expect{find('input[name="commit"]').click}.to change { Message.count }.by(1)
      expect(current_path).to eq(quest_path(@quest))
      #評価一覧にメッセージが表示されている。
      click_on '評価を見る・送る'
      expect(page).to have_content('テスト')
    end
  end
  context 'メッセージを送信できないとき' do
    it 'メッセージを送信済みのユーザーは選択できないようになっている' do
      #ボランティアに応募したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user)
      #募集要項ページに遷移し評価を記入し送信する
      visit quest_path(@quest)
      click_on '評価を見る・送る'
      select("#{user_name(@join.user)}", from: 'message[sending_party_id]')
      fill_message
      expect{find('input[name="commit"]').click}.to change { Message.count }.by(1)
      #評価を見るタブに移動し、評価相手を選択しようとすると「名前（評価済み）」となり選択できないようになっている
      click_on '評価を見る・送る'
      expect(find('select[name="message[sending_party_id]"]').click).to have_content("#{user_name(@join.user)}さん（評価済み）"), disabled: true 
    end
  end
end

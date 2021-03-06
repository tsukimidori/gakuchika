require 'rails_helper'

RSpec.describe "ボランティア募集（新規）", type: :system do
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
      fill_quest(@quest)
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
      fill_quest(@quest)
      fill_in '報酬形態', with: ''
      fill_in 'アピールポイント', with: ''
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

  context 'ボランティア募集できないとき' do
    image = Rails.root.join('public/images/test.png')

    it 'タイトルを入力していないときは新規投稿ページに戻される' do
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
      fill_quest(@quest)
      fill_in 'タイトル', with: ''
      #投稿するボタンを押してもQuestモデルのカウントが上がらない
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      #新規投稿ページに戻っている
      expect(current_path).to eq(quests_path)
    end
    it '募集予定人数を入力していないときは新規投稿ページに戻される' do
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
      fill_quest(@quest)
      fill_in '募集予定人数', with: ''
      #投稿するボタンを押してもQuestモデルのカウントが上がらない
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      #新規投稿ページに戻っている
      expect(current_path).to eq(quests_path)
    end
    it '活動日を入力していないときは新規投稿ページに戻される' do
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
      fill_quest(@quest)
      fill_in '活動日', with: ''
      #投稿するボタンを押してもQuestモデルのカウントが上がらない
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      #新規投稿ページに戻っている
      expect(current_path).to eq(quests_path)
    end
    it '応募者資格を入力していないときは新規投稿ページに戻される' do
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
      fill_quest(@quest)
      fill_in '応募者資格', with: ''
      #投稿するボタンを押してもQuestモデルのカウントが上がらない
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      #新規投稿ページに戻っている
      expect(current_path).to eq(quests_path)
    end
    it '活動地域を選択していないときは新規投稿ページに戻される' do
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
      select(@quest.target_attribute_name, from: 'quest[target_attribute_id]')
      fill_in '募集詳細', with: @quest.detail
      #投稿するボタンを押してもQuestモデルのカウントが上がらない
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      #新規投稿ページに戻っている
      expect(current_path).to eq(quests_path)
    end
    it '応募対象者を選択していないときは新規投稿ページに戻される' do
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
      fill_in '募集詳細', with: @quest.detail
      #投稿するボタンを押してもQuestモデルのカウントが上がらない
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      #新規投稿ページに戻っている
      expect(current_path).to eq(quests_path)
    end
    it 'ログイン状態でないときはマイページが表示されないため募集できない' do
      #トップページに遷移する
      basic_path(root_path)
      #マイページが表示されていない
      expect(page).to have_no_content('マイページ')
    end
    it '他人のマイページではボランティアを募集するボタンが表示されない' do
      user_oth = FactoryBot.create(:user)
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user)
      #別のユーザーのマイページへ遷移
      visit user_path(user_oth)
      #ボランティアを募集するボタンが表示されていない
      expect(page).to have_no_content('ボランティアを募集する')
    end
    it '未ログイン状態でボランティア募集投稿ページへURLで遷移しようとしてもログインページへ遷移する' do
      #トップページに遷移する
      basic_path(root_path)
      #URLから直接ボランティア投稿ページへ遷移しようとするとログインページ遷移する
      visit new_quest_path
      expect(current_path).to eq(user_session_path)
    end
  end
end

RSpec.describe "ボランティア募集（編集）", type: :system do
  before do
    @quest = FactoryBot.create(:quest)
    @user_oth = FactoryBot.create(:user)
    @quest_oth = FactoryBot.build(:quest)
    @quest_oth.user.last_name = "田中"
    @quest_oth.user.first_name = "一郎"
    @image_oth = Rails.root.join('public/images/test2.png')
  end

  context 'ボランティア募集内容を編集できるとき' do
    it '正しい情報で全て入力するとボランティア編集ができ募集詳細ページに遷移する' do
      #ボランティアを投稿したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@quest.user)
      #投稿したユーザーが募集要項ページに遷移すると編集するボタンが表示されていることを確認する
      visit quest_path(@quest)
      expect(page).to have_link '編集する', href: edit_quest_path(@quest)
      #編集するボタンを押すと編集ページに遷移することを確認する
      find_button('編集する').click
      expect(current_path).to eq(edit_quest_path(@quest))
      #編集ページには画像を除く投稿済みの内容がフォームに入っていることを確認する
      expect(find_by_id('quest_title').value).to eq(@quest.title)
      expect(find_by_id('quest_reward').value).to eq(@quest.reward)
      expect(find_by_id('quest_capacity').value.to_i).to eq(@quest.capacity)
      expect(find_by_id('quest_date').value.to_date).to eq(@quest.date)
      expect(find_by_id('quest_target').value).to eq(@quest.target)
      expect(find_by_id('quest_point').value).to eq(@quest.point)
      expect(find_by_id('quest_place_id').value.to_i).to eq(@quest.place_id)
      expect(find_by_id('quest_target_attribute_id').value.to_i).to eq(@quest.target_attribute_id)
      expect(find_by_id('quest_detail').value).to eq(@quest.detail)
      #編集を行い投稿するボタンを押すとQuestモデルのカウントは上がらずに募集詳細ページに遷移する
      attach_file('quest[image]', @image_oth, make_visible: true)
      fill_quest(@quest_oth)
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      expect(current_path).to eq(quest_path(@quest))
      #募集詳細ページの基本情報タブに募集詳細以外の変更が反映されて表示されている（募集者の氏名は変更されていないことも確認）
      expect(page).to have_selector("img[src$='test2.png']")
      expect(page).to have_content(@quest_oth.title)
      expect(page).to have_content(@quest.user.last_name)
      expect(page).to have_content(@quest.user.first_name)
      expect(page).to have_content(@quest_oth.capacity)
      expect(page).to have_content(@quest_oth.date.strftime("%Y/%m/%d"))
      expect(page).to have_content(@quest_oth.place_name)
      expect(page).to have_content(@quest_oth.reward)
      expect(page).to have_content(@quest_oth.point)
      expect(page).to have_content(@quest_oth.target)
      expect(page).to have_content(@quest_oth.target_attribute_name)
      #募集詳細ページの詳細情報タブに遷移すると募集詳細の変更が反映されて表示されている
      click_on '詳細情報'
      expect(page).to have_content(@quest_oth.detail)
    end
    it '画像、報酬形態、アピールポイント、募集詳細を入力していなくても募集内容の変更ができ募集詳細へ遷移する' do
      #ボランティアを投稿したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@quest.user)
      #投稿したユーザーが募集詳細ページに遷移すると編集するボタンが表示されていることを確認する
      visit quest_path(@quest)
      expect(page).to have_link '編集する', href: edit_quest_path(@quest)
      #編集するボタンを押すと編集ページに遷移することを確認する
      find_button('編集する').click
      expect(current_path).to eq(edit_quest_path(@quest))
      #編集を行い投稿するボタンを押すとQuestモデルのカウントは上がらずに募集詳細ページに遷移する
      fill_quest(@quest_oth)
      fill_in '報酬形態', with: ''
      fill_in 'アピールポイント', with: ''
      fill_in '募集詳細', with: ''
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      expect(current_path).to eq(quest_path(@quest))
      #募集詳細ページの基本情報タブに募集詳細以外の変更が反映されて表示されている（募集者の氏名と画像は変更されてていないことも確認）
      expect(page).to have_selector("img[src$='test.png']")
      expect(page).to have_content(@quest_oth.title)
      expect(page).to have_content(@quest.user.last_name)
      expect(page).to have_content(@quest.user.first_name)
      expect(page).to have_content(@quest_oth.capacity)
      expect(page).to have_content(@quest_oth.date.strftime("%Y/%m/%d"))
      expect(page).to have_content(@quest_oth.place_name)
      expect(page).to have_content(@quest_oth.target)
      expect(page).to have_content(@quest_oth.target_attribute_name)
    end
  end

  context 'ボランティア募集内容を編集できないとき' do
    it 'タイトルを入力していないときは案件編集ページに戻される' do
      #ボランティアを投稿したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@quest.user)
      #投稿したユーザーが募集詳細ページに遷移すると編集するボタンが表示されていることを確認する
      visit quest_path(@quest)
      expect(page).to have_link '編集する', href: edit_quest_path(@quest)
      #編集するボタンを押すと編集ページに遷移することを確認する
      find_button('編集する').click
      expect(current_path).to eq(edit_quest_path(@quest))
      #編集を行い投稿するボタンを押すとQuestモデルのカウントは上がらずに募集詳細ページに遷移する
      fill_quest(@quest_oth)
      fill_in 'タイトル', with: ''
      #投稿するボタンを押してもQuestモデルのカウントが上がらない
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      #案件編集ページに戻っている
      expect(current_path).to eq(quest_path(@quest))
    end
    it '募集予定人数を入力していないときは案件編集ページに戻される' do
      #ボランティアを投稿したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@quest.user)
      #投稿したユーザーが募集詳細ページに遷移すると編集するボタンが表示されていることを確認する
      visit quest_path(@quest)
      expect(page).to have_link '編集する', href: edit_quest_path(@quest)
      #編集するボタンを押すと編集ページに遷移することを確認する
      find_button('編集する').click
      expect(current_path).to eq(edit_quest_path(@quest))
      #編集を行い投稿するボタンを押すとQuestモデルのカウントは上がらずに募集詳細ページに遷移する
      fill_quest(@quest_oth)
      fill_in '募集予定人数', with: ''
      #投稿するボタンを押してもQuestモデルのカウントが上がらない
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      #案件編集ページに戻っている
      expect(current_path).to eq(quest_path(@quest))
    end
    it '活動日を入力していないときは案件編集ページに戻される' do
      #ボランティアを投稿したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@quest.user)
      #投稿したユーザーが募集詳細ページに遷移すると編集するボタンが表示されていることを確認する
      visit quest_path(@quest)
      expect(page).to have_link '編集する', href: edit_quest_path(@quest)
      #編集するボタンを押すと編集ページに遷移することを確認する
      find_button('編集する').click
      expect(current_path).to eq(edit_quest_path(@quest))
      #編集を行い投稿するボタンを押すとQuestモデルのカウントは上がらずに募集詳細ページに遷移する
      fill_quest(@quest_oth)
      fill_in '活動日', with: ''
      #投稿するボタンを押してもQuestモデルのカウントが上がらない
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      #案件編集ページに戻っている
      expect(current_path).to eq(quest_path(@quest))
    end
    it '応募者資格を入力していないときは案件編集ページに戻される' do
      #ボランティアを投稿したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@quest.user)
      #投稿したユーザーが募集詳細ページに遷移すると編集するボタンが表示されていることを確認する
      visit quest_path(@quest)
      expect(page).to have_link '編集する', href: edit_quest_path(@quest)
      #編集するボタンを押すと編集ページに遷移することを確認する
      find_button('編集する').click
      expect(current_path).to eq(edit_quest_path(@quest))
      #編集を行い投稿するボタンを押すとQuestモデルのカウントは上がらずに募集詳細ページに遷移する
      fill_quest(@quest_oth)
      fill_in '応募者資格', with: ''
      #投稿するボタンを押してもQuestモデルのカウントが上がらない
      expect{find('input[name="commit"]').click}.to change { Quest.count }.by(0)
      #案件編集ページに戻っている
      expect(current_path).to eq(quest_path(@quest))
    end
    it '他人が投稿したボランティア詳細には編集するボタンが表示されない' do
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user_oth)
      #別のユーザーが投稿した募集詳細へ遷移
      visit quest_path(@quest)
      #ボランティアを編集するボタンが表示されていない
      expect(page).to have_no_content('編集する')
    end
    it '未ログイン状態で編集ページへURLで遷移しようとしてもログインページへ遷移する' do
      #トップページに遷移する
      basic_path(root_path)
      #URLから直接ボランティア編集ページへ遷移しようとするとログインページ遷移する
      visit edit_quest_path(@quest)
      expect(current_path).to eq(user_session_path)
    end
    it '他人が投稿したボランティアの編集ページへURLで遷移しようとしても案件詳細ページへ遷移する' do
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user_oth)
      #URLから直接ボランティア編集ページへ遷移しようとすると募集要項ページへ遷移する
      visit edit_quest_path(@quest)
      expect(current_path).to eq(quest_path(@quest))
    end
    it '参加者が1人以上いる場合は編集するボタンが表示されない' do
      join = FactoryBot.create(:join)
      user = join.quest.user  #ボランティア投稿者
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(user)
      #投稿した募集詳細へ遷移
      visit quest_path(join.quest)
      #ボランティアを編集するボタンが表示されていない
      expect(page).to have_no_content('編集する')
    end
    it '参加者が1人以上いる場合に編集ページへURLで遷移しようとしても案件詳細ページに遷移する' do
      join = FactoryBot.create(:join)
      user = join.quest.user
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(user)
      #URLから直接ボランティア編集ページへ遷移しようとすると案件詳細ページ遷移する
      visit edit_quest_path(join.quest)
      expect(current_path).to eq(quest_path(join.quest))
    end
  end
end

RSpec.describe "ボランティア募集（削除）", type: :system do
  before do
    @quest = FactoryBot.create(:quest)
    @user_oth = FactoryBot.create(:user)
  end

  context '募集を削除できるとき' do
    it '投稿したユーザーは募集を削除できる' do
      #ボランティアを投稿したユーザーでログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@quest.user)
      #投稿したユーザーが募集詳細ページに遷移すると編集するボタンが表示されていることを確認する
      visit quest_path(@quest)
      expect(page).to have_link '破棄する', href: quest_path(@quest)
      #破棄するボタンを押すとQuestモデルのカウントが1下がりトップページへ遷移する
      expect{find_button('破棄する').click}.to change { Quest.count }.by(-1)
      expect(current_path).to eq(root_path)
    end
  end
  context '募集を削除できないとき' do
    it '他人が投稿したボランティア詳細には破棄するボタンが表示されない' do
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user_oth)
      #別のユーザーが投稿した募集詳細へ遷移
      visit quest_path(@quest)
      #ボランティアを編集するボタンが表示されていない
      expect(page).to have_no_content('破棄する')
    end
    it '参加者が1人以上いる場合は破棄するボタンが表示されない' do
      join = FactoryBot.create(:join)
      user = join.quest.user  #ボランティア投稿者
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(user)
      #投稿した募集詳細へ遷移
      visit quest_path(join.quest)
      #ボランティアを編集するボタンが表示されていない
      expect(page).to have_no_content('破棄する')
    end
  end
end

RSpec.describe "ボランティア募集（応募・申請取消）", type: :system do
  before do
    @quest = FactoryBot.create(:quest)
    @user_oth = FactoryBot.create(:user)
  end

  context 'ボランティアに応募できるとき' do
    it '募集要項ページの「応募する」ボタンを押すとボランティアに応募できる' do
      #募集要項ページまで遷移し「応募する」ボタンが表示されていることを確認する
      basic_path(root_path)
      sign_in(@user_oth)
      visit quest_path(@quest)
      expect(page).to have_link '応募する', href: quest_applies_path(@quest)
      #「応募する」ボタンをクリックするとApplyモデルのカウントが1上がり募集要項ページへ戻ってくる
      expect{find_button('応募する').click}.to change { Apply.count }.by(1)
      expect(current_path).to eq(quest_path(@quest))
    end
  end
  context 'ボランティアの応募申請を取り消せるとき' do
    it '応募申請が承認前なら取り消せる' do
      apply = FactoryBot.create(:apply)  #応募済みボランティアを作成
      #募集要項ページまで遷移し「申請取消」ボタンが表示されていることを確認する
      basic_path(root_path)
      sign_in(apply.user)
      visit quest_path(apply.quest)
      expect(page).to have_link '申請取消', href: quest_apply_path(apply.quest, apply)
      #「申請取消」ボタンをクリックするとApplyモデルのカウントが1下がり募集要項ページへ戻ってくる
      expect{find_button('申請取消').click}.to change { Apply.count }.by(-1)
      expect(current_path).to eq(quest_path(apply.quest))
    end
  end
  context 'ボランティアに応募できないとき' do
    it '自身が投稿した募集には「応募する」ボタンが表示されない' do
      #募集要項ページまで遷移し「応募する」ボタンが表示されていないことを確認する
      basic_path(root_path)
      sign_in(@quest.user)
      visit quest_path(@quest)
      expect(page).to have_no_link '応募する', href: quest_applies_path(@quest)
    end
    it '一度応募すると申請取り消しするまで「応募する」ボタンが表示されない' do
      #募集要項ページまで遷移し「応募する」ボタンが表示されていることを確認する
      basic_path(root_path)
      sign_in(@user_oth)
      visit quest_path(@quest)
      expect(page).to have_link '応募する', href: quest_applies_path(@quest)
      #「応募する」ボタンをクリックするとApplyモデルのカウントが1上がり募集要項ページへ戻ってくる
      expect{find_button('応募する').click}.to change { Apply.count }.by(1)
      expect(current_path).to eq(quest_path(@quest))
      #「応募する」ボタンが表示されなくなり、「申請取消」ボタンが表示されていることを確認する
      expect(page).to have_no_link '応募する', href: quest_applies_path(@quest)
      expect(page).to have_content('申請取消')
    end
  end
end

RSpec.describe "ボランティア募集（承認・却下・参加取消）", type: :system do
  before do
    @apply = FactoryBot.create(:apply)
    @user_oth = FactoryBot.create(:user)
    @user = @apply.quest.user  #募集者
    @name = @apply.user.last_name + @apply.user.first_name  #応募者名
  end

  context '応募承認できるとき' do
    it '募集者が承認待ち一覧から「承認」ボタンを押すと参加承認できる' do
      #募集者で募集要項ページまで遷移し「承認待ち一覧」ボタンが表示されていることを確認し遷移する
      basic_path(root_path)
      sign_in(@user)
      visit quest_path(@apply.quest)
      expect(page).to have_link '承認待ち一覧', href: quest_applies_path(@apply.quest)
      find_button('承認待ち一覧').click
      expect(current_path).to eq(quest_applies_path(@apply.quest))
      #承認待ち一覧に承認待ちのユーザー（apply.user）の名前が表示されていることを確認する
      expect(page).to have_content(@name)
      #「承認」ボタンを押すとJoinモデルのカウントが1上がり、承認されたユーザー名が一覧から消える
      expect{find_button('承認').click}.to change { Join.count }.by(1)
      expect(page).to have_no_content(@name)
    end
  end
  context '応募却下できるとき' do
    it '募集者が承認待ち一覧から「却下」ボタンを押すと参加を却下できる' do
      #募集者で承認待ち一覧まで遷移する
      basic_path(root_path)
      sign_in(@user)
      visit quest_applies_path(@apply.quest)
      #「却下」ボタンを押すとApplyモデルのカウントが1下がり、募集要項に戻る
      expect{find_button('却下').click}.to change { Apply.count }.by(-1)
      expect(current_path).to eq(quest_path(@apply.quest))
    end
  end
  context '参加取消できるとき' do
    it '参加者は募集要項から参加取消できる' do
      join = FactoryBot.create(:join)
      user = join.user  #参加者
      quest = join.quest
      #参加者で募集要項ページまで遷移し「参加取消」ボタンが表示されていることを確認する
      basic_path(root_path)
      sign_in(user)
      visit quest_path(quest)
      expect(page).to have_link '参加取消', href: quest_join_path(quest, join)
      #「参加取消」ボタンをクリックするとJoinモデルのカウントが1下がり募集要項ページへ戻ってくる
      expect{find_button('参加取消').click}.to change { Join.count }.by(-1)
      expect(current_path).to eq(quest_path(quest))
    end
  end
  context '応募の承認・却下ができないとき' do
    it '募集者以外のユーザーは「承認待ち一覧」の表示がされない' do
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user_oth)
      #別のユーザーが投稿した募集詳細へ遷移
      visit quest_path(@apply.quest)
      #ボランティアを編集するボタンが表示されていない
      expect(page).to have_no_content('承認待ち一覧')
    end
    it '未ログイン状態でURLから承認待ち一覧へ遷移しようとしてもログインページへ遷移する' do
      #トップページに遷移する
      basic_path(root_path)
      #URLから直接ボランティア編集ページへ遷移しようとするとログインページ遷移する
      visit quest_applies_path(@apply.quest)
      expect(current_path).to eq(user_session_path)
    end
    it '募集者以外のユーザーがURLから承認待ち一覧へ遷移しようとしても募集要項ページへ遷移する' do
      #ログインしてトップページに遷移する
      basic_path(root_path)
      sign_in(@user_oth)
      #URLから直接承認待ち一覧ページへ遷移しようとすると募集要項ページへ遷移する
      visit quest_applies_path(@apply.quest)
      expect(current_path).to eq(quest_path(@apply.quest))
    end
  end
end
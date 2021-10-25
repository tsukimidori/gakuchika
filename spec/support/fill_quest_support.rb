module FillQuestSupport
  def fill_quest(quest)
    fill_in 'タイトル', with: quest.title
    fill_in '報酬形態', with: quest.reward
    fill_in '募集予定人数', with: quest.capacity
    fill_in '活動日', with: quest.date
    fill_in '応募者資格', with: quest.target
    fill_in 'アピールポイント', with: quest.point
    select(quest.place_name, from: 'quest[place_id]')
    select(quest.target_attribute_name, from: 'quest[target_attribute_id]')
    fill_in '募集詳細', with: quest.detail
  end
end
class TargetAttribute < ActiveHash::Base
  self.data = [
    { id: 1, name: 'どなたでも参加可能' },
    { id: 2, name: '大学生・専門学校生' },
    { id: 3, name: '社会人のみ' },
    { id: 4, name: '未成年（保護者付き添い）' },
    { id: 5, name: 'その他（詳細をご覧ください）' }
  ]

  include ActiveHash::Associations
  has_many :quests

end
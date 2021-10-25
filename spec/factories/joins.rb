FactoryBot.define do
  factory :join do
    association :user
    association :quest
  end
end
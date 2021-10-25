FactoryBot.define do
  factory :apply do
    association :user
    association :quest
  end
end
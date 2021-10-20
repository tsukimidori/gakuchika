FactoryBot.define do
  factory :message do
    message {Faker::Lorem.characters(number: 10)}
    like {5}

    association :user
    association :quest
  end
end

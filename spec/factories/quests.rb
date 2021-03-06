FactoryBot.define do
  factory :quest do
    title               {'テスト'}
    reward              {'テスト'}
    date                {Faker::Date.in_date_period}
    target              {'2022年卒予定者'}
    point               {Faker::Lorem.sentence}
    detail              {Faker::Lorem.sentence}
    place_id            {5}
    target_attribute_id {1}
    capacity            {2}

    association :user

    after(:build) do |quest|
      quest.image.attach(io: File.open('public/images/test.png'), filename: 'test.png')
    end
  end
end

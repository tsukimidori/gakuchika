FactoryBot.define do
  factory :user do
    last_name             {'試験'}
    first_name            {'一号'}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end
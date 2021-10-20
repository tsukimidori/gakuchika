FactoryBot.define do
  factory :user do
    last_name             {'試験'}
    first_name            {'一号'}
    email                 {Faker::Internet.free_email}
    password              {'abc123'}
    password_confirmation {password}
  end
end
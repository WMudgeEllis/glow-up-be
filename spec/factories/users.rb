FactoryBot.define do
  factory :user do
    username { 'User' }
    email { Faker::Internet.email }
    password { 'hello' }
    password_confirmation { 'hello' }
  end
end

FactoryBot.define do
  factory :user do
    username { 'User' }
    password { 'hello' }
    password_confirmation { 'hello' }
  end
end

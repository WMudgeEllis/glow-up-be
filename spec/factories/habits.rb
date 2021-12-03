FactoryBot.define do
  factory :habit do
    name { Faker::FunnyName.name }
    description { Faker::Lorem.sentence }
  end
end

FactoryBot.define do
  factory :habit do
    name { Faker::FunnyName.name }
  end
end

FactoryBot.define do
  factory :mood do
    association :user

    mood { [0, 1, 2, 3, 4].sample }
    description { Faker::Lorem.sentence }
  end
end

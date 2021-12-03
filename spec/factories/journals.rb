FactoryBot.define do
  factory :journal do
    name { Faker::Movies::StarWars.character }
    details { Faker::Lorem.sentence }
  end
end

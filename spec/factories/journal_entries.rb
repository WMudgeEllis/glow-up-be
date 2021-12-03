FactoryBot.define do
  factory :journal_entry do
    content { Faker::Lorem.sentence }
    association :user
    association :journal
  end
end

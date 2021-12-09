FactoryBot.define do
  factory :habit_entry do
    association :user
    association :habit
  end
end

FactoryBot.define do
  factory :habit_entry do
    status { [0, 1].sample }
    association :user
    association :habit
  end
end

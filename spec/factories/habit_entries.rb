FactoryBot.define do
  factory :habit_entry do
    status { 1 }
    user { nil }
    habit { nil }
  end
end

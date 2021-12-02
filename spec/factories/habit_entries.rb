FactoryBot.define do
  factory :habit_entry do
    date { "2021-12-01 23:39:19" }
    status { 1 }
    user { nil }
    habit { nil }
  end
end

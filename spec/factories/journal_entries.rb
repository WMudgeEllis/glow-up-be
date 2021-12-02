FactoryBot.define do
  factory :journal_entry do
    date { "2021-12-01 23:36:15" }
    content { "MyString" }
    user { nil }
    journal { nil }
  end
end

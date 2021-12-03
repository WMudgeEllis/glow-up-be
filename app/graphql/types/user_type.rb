module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :moods, [Types::MoodType], null: true
    field :journal_entries, [Types::JournalEntryType]
    field :journals, [Types::JournalType]
    field :habit_entries, [Types::HabitEntryType]
    field :habits, [Types::HabitType]
    field :weekly_moods, [Types::MoodType], null: true

    def weekly_moods
      object.moods.order(created_at: :desc).limit(7)
    end

    def monthly_moods
      object.moods.order(created_at: :desc)
      .where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)
    end

    def journals
      object.journals.distinct
    end

    def habits
      object.habits.distinct
    end
  end
end

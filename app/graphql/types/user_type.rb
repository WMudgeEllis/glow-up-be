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

    def habits
      object.habits.distinct
    end

    def journals
      object.journals.distinct
    end
  end
end

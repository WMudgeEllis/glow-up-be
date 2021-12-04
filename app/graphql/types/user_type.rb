module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :moods, [Types::MoodType], null: true
    field :journal_entries, [Types::JournalEntryType]
    field :journals, [Types::JournalType]
    field :habit_entries, [Types::HabitEntryType]
    field :habits, [Types::HabitType]
    field :weekly_habits, [Types::HabitEntryType]
    field :weekly_moods, [Types::MoodType], null: true

    def weekly_moods
      object.weekly_moods
    end

    def journals
      object.journals.distinct
    end

    def habits
      Habit.all
    end

    def weekly_habits
      object.weekly_habits
    end
  end
end

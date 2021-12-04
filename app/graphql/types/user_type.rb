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
    field :monthly_moods, [Types::MoodType], null: true

    def weekly_moods
      object.weekly_moods
    end

    def monthly_moods
      object
        .moods
        .order(created_at: :desc)
        .where(created_at: Date.today.at_beginning_of_month..Date.today.at_end_of_month)
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

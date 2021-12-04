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
      object.moods.order(created_at: :desc).limit(7)
    end

    def journals
      object.journals.distinct
    end

    def habits
      #will need to be changed if we want user createable habits
      Habit.all
    end

    def weekly_habits
      object
        .habit_entries
        .where('habit_entries.created_at > ?', Date.today - 7)
        .group('habit_entries.created_at, habit_entries.id')
        .order('habit_entries.created_at DESC')
    end
  end
end

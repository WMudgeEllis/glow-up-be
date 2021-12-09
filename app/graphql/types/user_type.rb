module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :journal_entries, [Types::JournalEntryType]
    field :weekly_habits, [Types::HabitEntryType]
    field :weekly_moods, [Types::MoodType]
    field :daily_mood, Types::MoodType, null: true
    field :daily_habits, [Types::HabitType]
    field :monthly_moods, [Types::MoodType] do
      argument :month, Int, required: false
    end
    field :monthly_habits, [Types::HabitEntryType] do
      argument :month, Int, required: false
    end

    def daily_mood
      mood = object.daily_mood

      raise GraphQL::ExecutionError.new('No Mood Selected') unless mood.is_a?(Mood)

      mood
    end

    def weekly_moods
      object.weekly_moods
    end

    def monthly_moods(month: Date.today.month)
      object.moods.monthly_moods(month)
    end

    def journal_entries
      object.weekly_journals
    end
    
    def daily_habits
      Habit.find(object.daily_habits)
    end

    def weekly_habits
      object.weekly_habits
    end

    def monthly_habits(month: Date.today.month)
      object.monthly_habits(month)
    end
  end
end

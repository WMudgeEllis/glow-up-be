module Queries
  class FetchHabits < Queries::BaseQuery
    type [Types::HabitType], null: false

    def resolve
      Habit.all
    end
  end
end

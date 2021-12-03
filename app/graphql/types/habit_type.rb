module Types
  class HabitType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :habit_entries, [Types::HabitEntryType]
    field :weekly_habit_entries, [Types::HabitEntryType]

    def weekly_habit_entries
      #if we add multiple users this needs to be changed, only adding it to maybe make the future easier
      user = User.first
      object.habit_entries
            .where('user_id = ?', user.id)
            .order(created_at: :desc)
            .limit(7)
    end
  end
end

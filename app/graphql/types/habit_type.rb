module Types
  class HabitType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :habit_entries, [Types::HabitEntryType]
  end
end

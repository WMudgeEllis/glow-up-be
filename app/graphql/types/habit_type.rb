module Types
  class HabitType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :habit_entries, [Types::HabitEntryType]
  end
end

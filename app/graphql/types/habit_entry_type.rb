module Types
  class HabitEntryType < Types::BaseObject
    field :id, ID, null: false
    field :date, GraphQL::Types::ISO8601DateTime, null: true
    field :status, Integer, null: true
    field :user_id, Integer, null: true
    field :habit_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

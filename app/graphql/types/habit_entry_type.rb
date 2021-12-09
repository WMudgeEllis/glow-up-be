module Types
  class HabitEntryType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :habit_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :date, String, null: false

    def date
      object.created_at
    end
  end
end

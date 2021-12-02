module Types
  class MoodType < Types::BaseObject
    field :id, ID, null: false
    field :mood, Integer, null: false
    field :description, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

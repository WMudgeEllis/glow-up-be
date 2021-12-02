module Types
  class JournalType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :details, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

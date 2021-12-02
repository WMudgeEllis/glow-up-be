module Types
  class JournalEntryType < Types::BaseObject
    field :id, ID, null: false
    field :date, GraphQL::Types::ISO8601DateTime, null: true
    field :content, String, null: true
    field :user_id, Integer, null: true
    field :journal_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

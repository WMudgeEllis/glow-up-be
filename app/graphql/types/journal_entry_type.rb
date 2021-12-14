module Types
  class JournalEntryType < Types::BaseObject
    field :id, ID, null: false
    field :content, String, null: true
    field :user_id, Integer, null: true
    field :journal_id, Integer, null: true
    field :date, GraphQL::Types::ISO8601DateTime, null: true

    def date
      object.created_at
    end
  end
end

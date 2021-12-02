module Types
  class JournalType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :details, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :journal_entries, [Types::JournalEntryType], null: true do
      argument :user_id, Integer
    end

    def journal_entries(user_id:)
      object.journal_entries.where(user_id: user_id)
    end
  end
end

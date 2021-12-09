module Mutations
  class CreateJournalEntry < Mutations::BaseMutation
    argument :params, Types::Input::JournalEntryInputType, required: true
    field :user, Types::UserType, null: false

    def resolve(params:)
      journal_params = Hash params
      user = User.first
      user.journal_entries.create!(journal_params
        .merge({ journal_id: Journal.first.id }))
        
      { user: user }
    end
  end
end

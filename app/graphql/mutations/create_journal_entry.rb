module Mutations
  class CreateJournalEntry < Mutations::BaseMutation
    argument :params, Types::Input::JournalEntryInputType, required: true
    argument :user_token, String, required: true

    field :user, Types::UserType, null: false

    def resolve(params:, user_token:)
      journal_params = Hash params
      user = User.decrypt_and_find(user_token)

      user.journal_entries.create!(journal_params
        .merge({ journal_id: Journal.first.id }))

      { user: user }
    end
  end
end

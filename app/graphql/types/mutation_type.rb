module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_mood, mutation: Mutations::CreateMood
    field :create_habit_entry, mutation: Mutations::CreateHabitEntry
    field :create_journal_entry, mutation: Mutations::CreateJournalEntry
    field :sign_in_user, mutation: Mutations::SignInUser
  end
end

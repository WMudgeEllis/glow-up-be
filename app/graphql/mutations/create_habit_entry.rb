module Mutations
  class CreateHabitEntry < Mutations::BaseMutation
    argument :params, [Types::Input::HabitEntryInputType], required: true
    argument :user_token, String, required: true

    field :user, Types::UserType, null: false

    def resolve(params:, user_token:)
      habits = params.map { |habit| Hash habit }
      user = User.decrypt_and_find(user_token)

      HabitEntry.create_entries(user, habits)

      { user: user }
    end
  end
end

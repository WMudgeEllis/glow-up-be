module Mutations
  class CreateHabitEntry < Mutations::BaseMutation
    argument :params, [Types::Input::HabitEntryInputType], required: true
    field :user, Types::UserType, null: false

    def resolve(params:)
      habits = params.map { |habit| Hash habit }
      user = User.first
      HabitEntry.create_entries(user, habits)

      { user: user }
    end
  end
end

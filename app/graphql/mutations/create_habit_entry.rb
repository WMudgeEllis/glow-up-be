module Mutations
  class CreateHabitEntry < Mutations::BaseMutation
    argument :params, [Types::Input::HabitEntryInputType], required: true
    field :user, Types::UserType, null: false

    def resolve(params:)
      habits = params.map { |habit| Hash habit }
      begin
        user = User.first
        habits.each do |habit|
          HabitEntry.create!(user_id: user.id, habit_id: habit[:id], status: 1)
        end

        { user: user }

      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}: "\
        "#{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end

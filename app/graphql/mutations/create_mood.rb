module Mutations
  class CreateMood < Mutations::BaseMutation
    argument :params, Types::Input::MoodInputType, required: true

    field :user, Types::UserType, null: false

    def resolve(params:)
      mood_params = Hash params
      begin
        user = User.find(1)
        user.moods.create!(mood_params)

        { user: user }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}: "\
        "#{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end

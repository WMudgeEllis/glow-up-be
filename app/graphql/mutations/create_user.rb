module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :params, Types::Input::UserCreateInputType, required: true

    field :token, String, null: true

    def resolve(params:)
      user_params = Hash params

      # user = User.create!(user_params)
      # token = user.generate_token

      user = User.new(user_params)

      if user.save
        { user: user, token: token }
      else
        errors = user.errors.full_messages
        raise GraphQL::ExecutionError, { errors: errors.to_sentence }
      end
    end
  end
end

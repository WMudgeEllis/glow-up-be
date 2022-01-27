module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :params, Types::Input::UserCreateInputType, required: true

    field :token, String, null: true

    def resolve(params:)
      user_params = Hash params

      # user = User.create!(user_params)

      user = User.new(user_params)
      token = user.generate_token

      if user.save
        { user: user, token: token }
      else
        errors = user.errors.full_messages
        raise GraphQL::ExecutionError, { message: errors.to_sentence }
      end
    end
  end
end

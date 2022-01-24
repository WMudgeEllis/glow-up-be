module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :params, Types::Input::UserCreateInputType, required: true

    field :token, String, null: true

    def resolve(params:)
      user_params = Hash params
      begin
        user = User.create!(user_params)
        token = user.generate_token

        { user: user, token: token }
      end
    end
  end
end

module Mutations
  class SignInUser < Mutations::BaseMutation
    argument :params, Types::Input::UserSignInInputType, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(params: nil)
      return unless params

      user = User.find_by(username: params[:username])
      token = user&.generate_token

      return unless user&.authenticate(params[:password])

      { user: user, token: token }
    end
  end
end

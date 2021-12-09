module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :params, Types::Input::UserCreateInputType, required: true

    field :user, Types::UserType, null: false

    def resolve(params:)
      user_params = Hash params
      begin
        user = User.create!(user_params)
        { user: user }
      end
    end
  end
end

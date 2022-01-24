module Types
  module Input
    class UserCreateInputType < Types::BaseInputObject
      argument :username, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
    end
  end
end

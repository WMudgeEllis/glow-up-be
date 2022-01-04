module Types
  module Input
    class UserSignInInputType < Types::BaseInputObject
      argument :username, String, required: true
      argument :password, String, required: true
    end
  end
end

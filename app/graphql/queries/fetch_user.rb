module Queries
  class FetchUser < Queries::BaseQuery
    type Types::UserType, null: false

    argument :token, String, required: true

    def resolve(token:)
      User.decrypt_and_find(token)
    end
  end
end

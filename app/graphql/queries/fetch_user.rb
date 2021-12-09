module Queries
  class FetchUser < Queries::BaseQuery
    type Types::UserType, null: false

    def resolve
      User.first
    end
  end
end

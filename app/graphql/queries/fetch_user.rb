module Queries
  class FetchUser < Queries::BaseQuery
    type Types::UserType, null: false

    def resolve
      User.first
    # rescue ActiveRecord::RecordNotFound => _e
    #   GraphQL::ExecutionError.new('User does not exist')
    # rescue ActiveRecord::InvalidRecord => e
    #   GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}: "\
    #   "#{e.record.errors.full_messages.join(', ')}")
    end
  end
end

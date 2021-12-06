module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :fetch_user, resolver: Queries::FetchUser
    field :fetch_habits, resolver: Queries::FetchHabits
  end
end

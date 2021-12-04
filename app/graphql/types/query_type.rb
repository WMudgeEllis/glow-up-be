module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :fetch_user, resolver: Queries::FetchUser
    field :fetch_habit, resolver: Queries::FetchHabits
  end
end

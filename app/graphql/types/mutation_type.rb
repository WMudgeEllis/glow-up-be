module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_mood, mutation: Mutations::CreateMood
  end
end

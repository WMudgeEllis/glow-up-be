require "rails_helper"

RSpec.describe 'create user' do
  it 'can create a user' do
    post '/graphql', params: { query: query }

    expect(User.count).to eq(1)
  end

  def query
      <<~GQL
      mutation{
        createUser(
          input:{
            params:{
              username: "Testing",
              password: "Seecrit",
              passwordConfirmation: "Seecrit"
            }
          }
        ) {
          clientMutationId
        }
      }
    GQL
  end
end

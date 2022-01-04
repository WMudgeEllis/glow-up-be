require "rails_helper"

RSpec.describe 'create user' do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:data) { json[:data][:createUser] }

  before { post '/graphql', params: { query: query } }

  it 'can create a user' do
    expect(User.count).to eq(1)
  end

  it 'returns username and token' do
    expect(data[:user][:username]).to eq('Testing')
    expect(data[:token]).to be_a(String)
  end

  def query
      <<~GQL
      mutation{
        createUser(
          input:{
            params:{
              username: "Testing",
              email: "email@email.com"
              password: "Seecrit",
              passwordConfirmation: "Seecrit"
            }
          }
        ) {
          user {
            username
          }
          token
        }
      }
    GQL
  end
end

require "rails_helper"

RSpec.describe 'sign in user' do
  let!(:user) { create :user, username: 'Testing', password: 'Seecrit', password_confirmation: 'Seecrit' }
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:data) { json[:data][:signInUser] }

  before { post '/graphql', params: { query: query } }

  it 'returns username and token' do
    expect(data[:user][:username]).to eq('Testing')
    expect(data[:token]).to be_a(String)
  end

  def query
      <<~GQL
      mutation{
        signInUser(
          input:{
            params:{
              username: "Testing",
              password: "Seecrit",
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

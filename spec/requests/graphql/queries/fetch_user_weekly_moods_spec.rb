require 'rails_helper'

describe 'Fetch User Weekly Moods' do
  let!(:user) { create :user }
  let!(:moods) do
    create_list :mood, 3, user_id: user.id, created_at: Date.current - 8

    (0..7).each do |num|
      create :mood, user_id: user.id, created_at: Date.current - num unless num == 2
    end
  end

  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:reduced) { json[:data] }
  let(:data) { reduced[:fetchUser] }

  before { post '/graphql', params: { query: query } }

  it 'returns past seven moods' do
    result = data[:weeklyMoods].first[:createdAt] > data[:weeklyMoods].last[:createdAt]

    expect(json).to_not have_key(:errors)
    expect(data[:weeklyMoods].length).to eq(6)
    expect(result).to be(true)
  end

  def query
    <<~GQL
      query fetchUser {
        fetchUser(token: "#{user_token}") {
          id
          weeklyMoods {
            createdAt
            description
            id
            mood
          }
        }
      }
    GQL
  end

  def login_query
    <<-GQL
      mutation{
        signInUser(
          input:{
            params:{
              username: "#{user.username}",
              password: "#{user.password}",
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

  def user_token
    post '/graphql', params: { query: login_query }

    body = JSON.parse(response.body, symbolize_names: true)

    body[:data][:signInUser][:token]
  end
end

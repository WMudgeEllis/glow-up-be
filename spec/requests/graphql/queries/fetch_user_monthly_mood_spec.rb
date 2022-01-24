require 'rails_helper'

describe 'Fetch User Query Monthly Moods' do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:reduced) { json[:data] }
  let(:data) { reduced[:fetchUser] }
  let!(:user) { create :user }

  before :each do
    allow(Date).to receive(:today).and_return Date.new(2021,3,28)
    (0..40).to_a.each do |num|
      mood = create :mood, user_id: user.id
      mood.update_attribute(:created_at, Date.today - num)
    end

  end

  it 'returns moods for current month' do
    post '/graphql', params: { query: query }

    result = data[:monthlyMoods].first[:createdAt] > data[:monthlyMoods].last[:createdAt]

    expect(json).to_not have_key(:errors)
    expect(data[:monthlyMoods].length).to eq(28)
    expect(result).to be(true)
  end

  it 'returns moods for specified month' do
    post '/graphql', params: { query: february }

    result = data[:monthlyMoods].first[:createdAt] > data[:monthlyMoods].last[:createdAt]

    expect(json).to_not have_key(:errors)
    expect(data[:monthlyMoods].length).to eq(13)
    expect(result).to be(true)
  end

  def query
    <<~GQL
      query fetchUser {
        fetchUser(token: "#{user_token}") {
          id
          monthlyMoods {
            createdAt
            description
            id
            mood
          }
        }
      }
    GQL
  end

  def february
    <<~GQL
      query fetchUser {
        fetchUser(token: "#{user_token}") {
          id
          monthlyMoods(month: 2) {
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

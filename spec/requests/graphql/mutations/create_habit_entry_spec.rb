require "rails_helper"

describe 'create habit entry' do
  let!(:user) { create :user }
  let!(:token) { user.generate_token }
  let!(:habit) { create :habit }

  before :each do
    create(:habit, id: 7)
    create(:habit, id: 13)
  end

  it 'can create a habit entry' do
    post '/graphql', params: { query: valid_query(user_token: token) }

    expect(user.habit_entries.count).to eq(2)
  end

  it 'returns errors when given bad query' do
    post '/graphql', params: { query: bad_query(user_token: token) }

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to have_key(:errors)
  end

  it 'can update habit entries' do
    post '/graphql', params: { query: valid_query(user_token: token) }

    post '/graphql', params: { query: update_query(user_token: token) }

    expect(user.habit_entries.count).to eq(1)
  end

  def valid_query(user_token:)
    <<~GQL
      mutation {
        createHabitEntry(
          input: {
            params: [{id: 13}, {id: 7}],
            userToken: "#{user_token}"
          }
        ) {
          user {
            id
          }
        }
      }
    GQL
  end

  def bad_query(user_token:)
    <<~GQL
      mutation {
        createHabitEntry(
          input: {
            haha_evil_query,
            userToken: "#{user_token}"
          }
        ) {
          user {
            id
          }
        }
      }
    GQL
  end

  def update_query(user_token:)
    <<~GQL
      mutation {
        createHabitEntry(
          input: {
            params: [{id: 7}],
            userToken: "#{user_token}"
          }
        ) {
          user {
            id
          }
        }
      }
    GQL
  end
end

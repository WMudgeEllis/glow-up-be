require 'rails_helper'

describe 'Fetch User Weekly Moods' do
  let!(:user) { create :user }
  let!(:moods) do
    create_list :mood, 7, user_id: user.id
    sleep(1)
    create_list :mood, 3, user_id: user.id
  end

  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:reduced) { json[:data] }
  let(:data) { reduced[:fetchUser] }

  before { post '/graphql', params: { query: query } }

  it 'returns past seven moods' do
    result = data[:weeklyMoods].first[:createdAt] > data[:weeklyMoods].last[:createdAt]

    expect(json).to_not have_key(:errors)
    expect(data[:weeklyMoods].length).to eq(7)
    expect(result).to be(true)
  end

  def query
    <<~GQL
      query fetchUser {
        fetchUser {
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
end

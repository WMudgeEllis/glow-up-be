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

    post '/graphql', params: { query: query }
  end

  it 'returns moods for current month' do
    result = data[:monthlyMoods].first[:createdAt] > data[:monthlyMoods].last[:createdAt]

    expect(json).to_not have_key(:errors)
    expect(data[:monthlyMoods].length).to eq(28)
    expect(result).to be(true)
  end

  def query
    <<~GQL
      query fetchUser {
        fetchUser {
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
end

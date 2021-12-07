require 'rails_helper'

describe 'Fetch User Daily Mood' do
  let!(:user) { create :user }
  let!(:moods2_days_ago) { create_list :mood, 3, created_at: Date.today - 2, user_id: user.id }
  let!(:mood) { create :mood, user_id: user.id, mood: 3 }
  let!(:moods_yesterday) { create_list :mood, 3, created_at: Date.today - 1, user_id: user.id }
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:mood_info) { json[:data][:fetchUser][:dailyMood] }

  before { post '/graphql', params: { query: query } }

  it 'has the mood for the day' do
    expect(mood_info[:id].to_i).to eq(mood.id)
    expect(mood_info[:mood].to_i).to eq(mood.mood)
  end

  def query
    <<-GQL
      query {
        fetchUser {
          dailyMood {
            id
            mood
          }
        }
      }
    GQL
  end
end

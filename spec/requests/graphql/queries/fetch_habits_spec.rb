require 'rails_helper'

describe 'Fetch Habits Query' do
  let!(:user) { create :user }
  let!(:habits) { create_list :habit, 5 }
  let!(:habit_entries) { create_list :habit_entry, 2, user_id: user.id, habit_id: habits.first.id }
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:data) { json[:data][:fetchHabits] }

  before { post '/graphql', params: { query: query } }

  it 'returns all the habits' do
    expect(json).to_not have_key :errors
    expect(data.size).to eq 5
  end

  it 'returns habit info for the habits' do
    habits.each_with_index do |habit, i|
      expect(data[i][:id]).to eq habit.id.to_s
      expect(data[i][:name]).to eq habit.name
    end
  end

  it 'has the habits habit entries' do
    expected = habit_entries.map { |habit| { id: habit.id.to_s } }

    expect(data.first[:habitEntries]).to eq(expected)
  end

  def query
    <<~GQL
      query {
        fetchHabits {
          id
          name
          habitEntries {
            id
          }
        }
      }
    GQL
  end
end

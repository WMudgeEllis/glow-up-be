require "rails_helper"


RSpec.describe 'monthly habits' do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:reduced) { json[:data] }
  let(:data) { reduced[:fetchUser][:data] }
  let!(:user) { create :user }
  let!(:habit) { create :habit }

  before :each do
    allow(Date).to receive(:today).and_return Date.new(2021,3,28)

    (0..40).to_a.each do |num|
      user.habit_entries.create!(habit_id: habit.id, status: 1, created_at: Date.today - num)
    end
  end

  it 'returns monthly habits with default' do
    post '/graphql', params: { query: query }

    expect(data).to have_key(:monthlyHabits)
    expect(data[:monthlyHabits].length).to eq(30)
    expect(data[:monthlyHabits].first).to have_key(:id)
    expect(data[:monthlyHabits].first).to have_key(:date)
    expect(data[:monthlyHabits].first).to have_key(:habitId)
    expect(data[:monthlyHabits].first).to have_key(:status)

    ordered = data[:monthlyHabits].first.date > data[:monthlyHabits].last.date

    expect(ordered).to eq(true)
  end

  it 'returns mothly habits specified by month' do
    post '/graphql', params: { query: query_specified }

    expect(data[:monthlyHabits].length).to eq(13)
  end

  def query
    <<~GQL
      query {
        fetchUser {
          monthlyHabits {
            id
            date
            habitId
            status
          }
        }
      }
    GQL
  end

  def query_specified
    <<~GQL
      query {
        fetchUser {
          monthlyHabits(month: 2) {
            id
            date
            habitId
            status
          }
        }
      }
    GQL
  end
end

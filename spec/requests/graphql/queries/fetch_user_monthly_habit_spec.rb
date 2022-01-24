require "rails_helper"


RSpec.describe 'monthly habits' do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:reduced) { json[:data] }
  let(:data) { json[:data][:fetchUser] }
  let!(:user) { create :user }
  let!(:habit) { create :habit }

  before :each do
    allow(Date).to receive(:today).and_return Date.new(2021,3,28)

    (0..40).to_a.each do |num|
      user.habit_entries.create!(habit_id: habit.id, created_at: Date.today - num)
    end
  end

  it 'returns monthly habits with default' do
    post '/graphql', params: { query: query }
    expect(data).to have_key(:monthlyHabits)
    expect(data[:monthlyHabits].length).to eq(28)
    expect(data[:monthlyHabits].first).to have_key(:id)
    expect(data[:monthlyHabits].first).to have_key(:date)
    expect(data[:monthlyHabits].first).to have_key(:habitId)

    ordered = data[:monthlyHabits].first[:date] > data[:monthlyHabits].last[:date]

    expect(ordered).to eq(true)
  end

  it 'returns mothly habits specified by month' do
    post '/graphql', params: { query: query_specified }

    expect(data[:monthlyHabits].length).to eq(13)
  end

  def query
    <<~GQL
      query {
        fetchUser(token: "#{user_token}") {
          monthlyHabits {
            id
            date
            habitId
          }
        }
      }
    GQL
  end

  def query_specified
    <<~GQL
      query {
        fetchUser(token: "#{user_token}") {
          monthlyHabits(month: 2) {
            id
            date
            habitId
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

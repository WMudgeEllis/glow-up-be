require 'rails_helper'

describe 'Fetch User Daily Mood and Habits' do
  let!(:user) { create :user }
  let!(:habits) { create_list :habit, 3 }
  let!(:moods2_days_ago) { create_list :mood, 3, created_at: Date.current - 2, user_id: user.id }
  let!(:mood) { create :mood, user_id: user.id, mood: 3 }
  let!(:moods_yesterday) { create_list :mood, 3, created_at: Date.current - 1, user_id: user.id }
  let!(:yesterday_habits) { create_list :habit_entry, 3, user_id: user.id, habit_id: habits.last.id, created_at: Date.current - 1 }
  let!(:daily_habit1) { create :habit_entry, user_id: user.id, habit_id: habits.first.id, created_at: Date.current }
  let!(:daily_habit2) { create :habit_entry, user_id: user.id, habit_id: habits[1].id, created_at: Date.current }
  let!(:daily_habit3) { create :habit_entry, user_id: user.id, habit_id: habits.last.id, created_at: Date.current }
  let!(:two_days_ago_habits) { create_list :habit_entry, 3, user_id: user.id, habit_id: habits.first.id, created_at: Date.current - 2 }

  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:mood_info) { json[:data][:fetchUser][:dailyMood] }
  let(:habit_info) { json[:data][:fetchUser][:dailyHabits] }

  it 'has the mood for the day' do
    post '/graphql', params: { query: mood_query }

    expect(mood_info[:id].to_i).to eq(mood.id)
    expect(mood_info[:mood].to_i).to eq(mood.mood)
  end

  it 'has daily completed habits' do
    post '/graphql', params: { query: habits_query }

    expect(habit_info.size).to eq(3)
    expect(habit_info.first[:id].to_i).to eq(habits.first.id)
    expect(habit_info.last[:id].to_i).to eq(habits.last.id)
  end

  it 'returns error with no daily mood' do
    (3..31).to_a.each do |num|
      create(:mood, user_id: user.id, created_at: Date.current - num)
    end

    mood.destroy

    post '/graphql', params: { query: mood_query }

    expect(mood_info).to be nil
  end

  it 'returns only todays completed habits' do
    new_habit = create(:habit)
    (3..63).to_a.each do |num|
      create(:habit_entry, user_id: user.id, habit_id: new_habit.id, created_at: Date.current - num)
    end

    post '/graphql', params: { query: habits_query }

    expect(habit_info.last[:id].to_i).to eq(habits.last.id)
  end

  def mood_query
    <<-GQL
      query {
        fetchUser(token: "#{user_token}") {
          dailyMood {
            id
            mood
          }
        }
      }
    GQL
  end

  def habits_query
    <<-GQL
      query {
        fetchUser(token: "#{user_token}") {
          dailyHabits {
            id
            name
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

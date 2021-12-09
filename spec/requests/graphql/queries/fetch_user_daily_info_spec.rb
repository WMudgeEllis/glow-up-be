require 'rails_helper'

describe 'Fetch User Daily Mood and Habits' do
  let!(:user) { create :user }
  let!(:habits) { create_list :habit, 3 }
  let!(:moods2_days_ago) { create_list :mood, 3, created_at: Date.today - 2, user_id: user.id }
  let!(:mood) { create :mood, user_id: user.id, mood: 3 }
  let!(:moods_yesterday) { create_list :mood, 3, created_at: Date.today - 1, user_id: user.id }
  let!(:yesterday_habits) { create_list :habit_entry, 3, user_id: user.id, habit_id: habits.last.id, created_at: Date.today - 1 }
  let!(:daily_habit1) {  create :habit_entry, user_id: user.id, habit_id: habits.first.id, created_at: Date.today }
  let!(:daily_habit2) {  create :habit_entry, user_id: user.id, habit_id: habits[1].id, created_at: Date.today }
  let!(:daily_habit3) {  create :habit_entry, user_id: user.id, habit_id: habits.last.id, created_at: Date.today }
  let!(:two_days_ago_habits) { create_list :habit_entry, 3, user_id: user.id, habit_id: habits.first.id, created_at: Date.today - 2 }

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

  def mood_query
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

  def habits_query
    <<-GQL
      query {
        fetchUser {
          dailyHabits {
            id
            name
          }
        }
      }
    GQL
  end
end

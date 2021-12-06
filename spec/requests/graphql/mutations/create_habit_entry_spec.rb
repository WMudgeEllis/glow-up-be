require "rails_helper"

describe 'create habit entry' do

  before :each do
    @user = create(:user)
    @habit = create(:habit, id: 1)
    create(:habit, id: 7)
    create(:habit, id: 13)
  end

  it 'can create a habit entry' do
    post '/graphql', params: { query: query }

    expect(@user.habit_entries.count).to eq(3)
    expect(@user.habit_entries.first.status).to eq(1)
    expect(@habit.habit_entries.first.status).to eq(0)
  end

  it 'returns errors when given bad query' do
    post '/graphql', params: { query: bad_query }

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to have_key(:errors)
  end

  it 'can update habit entries' do
    post '/graphql', params: { query: query }

    post '/graphql', params: { query: update_query }

    expect(@user.habit_entries.count).to eq(Habit.all.count)
    expect(@user.habit_entries[1].status).to eq(1)
    expect(@habit.habit_entries.first.status).to eq(1)
  end

  def query
    <<~GQL
    mutation {
      createHabitEntry(
        input: {
          params: [{id: 13}, {id: 7}]
        }
      ) {
        user {
          id
        }
      }
    }
    GQL
  end

  def bad_query
    <<~GQL
    mutation {
      createHabitEntry(
        input: {
          haha_evil_query
        }
      ) {
        user {
          id
        }
      }
    }
    GQL
  end

  def update_query
    <<~GQL
    mutation {
      createHabitEntry(
        input: {
          params: [{id: 1}]
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

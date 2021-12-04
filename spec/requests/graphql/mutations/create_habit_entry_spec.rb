require "rails_helper"

RSpec.describe 'create habit entry' do

  before :each do
    @user = create(:user)
    create(:habit, id: 1)
    create(:habit, id: 2)
  end

  it 'can create a habit entry' do
    post 'graphql', params: { query: query }

    parsed = JSON.parse(response.body, symbolyze_names: true)

    expect(@user.habit_entries.count).to eq(2)
    expect(@user.habit_entries.first.status).to eq(1)
  end

  def query
    <<~GQL
    mutation {
      createHabitEntry(
        input: {
          params: {
            habit_ids: [1, 2]
          }
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

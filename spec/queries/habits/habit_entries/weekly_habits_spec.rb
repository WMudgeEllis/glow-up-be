require "rails_helper"


RSpec.describe 'get weekly habit entries' do

  before :each do
    @user = create(:user)
    @habit = create(:habit)
    create_list(:habit, 5)
  end

  it 'gets all habits' do
    result = GlowUpSchema.execute(query).as_json

    expect(result).to have_key("data")
    expect(result["data"]).to have_key("fetchUser")
    expect(result["data"]).to have_key("habits")
    expect(result["data"]["habits"]).to be_a(Array)
    expect(result["data"]["habits"].length).to eq(6)
  end

  it 'gets seven habit entries' do
    create_list(:habit_entry, 3, user_id: @user.id, habit_id: @habit.id)

    sleep(1)

    create_list(:habit_entry, 6, user_id: @user.id, habit_id: @habit.id)

    result = GlowUpSchema.execute(query).as_json

    expect(result["data"]["fetchUser"]["habits"].first).to have_key("weeklyHabitEntries")
    expect(result["data"]["fetchUser"]["habits"].first["weeklyHabitEntries"]).to be_a(Array)
    expect(result["data"]["fetchUser"]["habits"].first["weeklyHabitEntries"]).to be_a(Array)
    expect(result["data"]["fetchUser"]["habits"].first["weeklyHabitEntries"].length).to eq(7)
    expect(result["data"]["fetchUser"]["habits"].first["weeklyHabitEntries"].first).to have_key("date")
    expect(result["data"]["fetchUser"]["habits"].first["weeklyHabitEntries"].first).to have_key("status")

  end

  def query
    <<~GQL
    {
      fetchUser{
        id
    		habits {
    		  id
          description
          weeklyHabitEntries {
            status
            date
          }
    		}
      }
    }
    GQL
  end
end

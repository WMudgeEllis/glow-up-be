require "rails_helper"


RSpec.describe 'get all habits with last seven habit entries' do

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

    expect(result["data"]["habits"].first).to have_key("status")
    expect(result["data"]["habits"].first).to have_key("habitEntries")
    expect(result["data"]["habits"].first["habitEntries"]).to be_a(Array)
    expect(result["data"]["habits"].first["habitEntries"]).to be_a(Array)
    expect(result["data"]["habits"].first["habitEntries"].length).to eq(7)
    expect(result["data"]["habits"].first["habitEntries"].length.first).to have_key("date")
    expect(result["data"]["habits"].first["habitEntries"].length.first).to have_key("status")

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
            createdAt
          }
    		}
      }
    }
    GQL
  end
end

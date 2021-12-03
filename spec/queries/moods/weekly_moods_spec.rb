require "rails_helper"

RSpec.describe 'get weekly moods' do

  before :each do
    @user = create(:user)
  end

  it 'can get past seven moods' do
    7.times do
      create(:mood, user_id: @user.id)
    end

    sleep(1)

    3.times do
      create(:mood, user_id: @user.id)
    end

    result = GlowUpSchema.execute(query).as_json

    expect(result).to_not have_key("errors")
    expect(result).to have_key("data")
    expect(result["data"]["fetchUser"]).to have_key("weeklyMoods")
    expect(result["data"]["fetchUser"]["weeklyMoods"]).to be_a(Array)
    expect(result["data"]["fetchUser"]["weeklyMoods"].length).to eq(7)
    expect(result["data"]["fetchUser"]["weeklyMoods"].first["createdAt"] > result["data"]["fetchUser"]["weeklyMoods"].last["createdAt"]).to eq(true)
  end


  def query
    <<~GQL

    {
      fetchUser{
        id
        weeklyMoods{
          createdAt
    			description
          id
          mood
        }
      }
    }

    GQL
  end
end

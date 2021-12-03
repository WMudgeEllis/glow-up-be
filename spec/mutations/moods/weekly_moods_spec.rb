require "rails_helper"

RSpec.describe 'get weekly moods' do

  before :each do
    @user = create(:user)
  end

  it 'can get past seven moods' do
    10.times do
      create(:mood, user_id: @user.id)
    end

    result = GlowUpSchema.execute(query).as_json

    expect(result).to_not have_key("errors")
    expect(result).to have_key("data")
    expect(result["data"]).to have_key("moods")
    expect(result["data"]["moods"]).to be_a(Array)
    expect(result["data"]["moods"].length).to eq(7)
    expect(result["data"]["moods"].first["createdAt"]).to be < result["data"]["moods"].last["createdAt"]
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
